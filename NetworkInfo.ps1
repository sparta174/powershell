﻿#########################################################
#
#  This script is to lookup Network Info for all the  
#  computers in a list you input
#  Version 1
#  Created by: Nick Ross
#  Create Date: 11/5/2018
#
#########################################################

[cmdletbinding()]
param (
 [parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
    [string[]]$ComputerName = $env:computername
)

$ComputerName = Import-CSV C:\support\PCList1.csv | Select-Object -ExpandProperty Name

 foreach ($Computer in $ComputerName) {
  if(Test-Connection -ComputerName $Computer -Count 1 -ea 0) {
   try {
    $Networks = Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $Computer -EA Stop | ? {$_.IPEnabled}
   } catch {
        Write-Warning "Error occurred while querying $computer."
        Continue
   }
   foreach ($Network in $Networks) {
    $IPAddress  = $Network.IpAddress[0]
    $SubnetMask  = $Network.IPSubnet[0]
    $DefaultGateway = $Network.DefaultIPGateway
    $DNSServers  = $Network.DNSServerSearchOrder
    $IsDHCPEnabled = $false
    If($network.DHCPEnabled) {
     $IsDHCPEnabled = $true
    }
    $MACAddress  = $Network.MACAddress
    $OutputObj  = New-Object -Type PSObject
    $OutputObj | Add-Member -MemberType NoteProperty -Name ComputerName -Value $Computer.ToUpper()
    $OutputObj | Add-Member -MemberType NoteProperty -Name IPAddress -Value $IPAddress
    $OutputObj | Add-Member -MemberType NoteProperty -Name SubnetMask -Value $SubnetMask
    $OutputObj | Add-Member -MemberType NoteProperty -Name Gateway -Value "$DefaultGateway"
    $OutputObj | Add-Member -MemberType NoteProperty -Name IsDHCPEnabled -Value $IsDHCPEnabled
    $OutputObj | Add-Member -MemberType NoteProperty -Name DNSServers -Value "$DNSServers"
    $OutputObj | Add-Member -MemberType NoteProperty -Name MACAddress -Value $MACAddress
    $OutputObj | Write-Output | Select-Object ComputerName, IPAddress, SubnetMask, Gateway, DNSServers, MACAddress | Export-Csv C:\support\NetworkInfo.csv -Append
   }
  }
 }