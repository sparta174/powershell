#########################################################
#
#  This script is to lookup Network Info for all the  
#  Servers in Active Directory
#  Version 1
#  Created by: Nick Ross
#  Create Date: 11/2/2018
#
#########################################################

# Sets the Param Binding
[cmdletbinding()]
param (
 [parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
    [string[]]$ComputerName = $env:computername
)

# Imports the PC List
$ComputerList = Get-AdComputer -Filter 'OperatingSystem -like "*Server*"' -Properties Name

# For loop to start the fun :)
 foreach ($Computer in $ComputerList) {
 # Test the connection, if it works, keep going, if not, skip
  if(Test-Connection -ComputerName $Computer -Count 1 -ea 0) {
   try {
    $Networks = Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $Computer -EA Stop | ? {$_.IPEnabled}
   } catch {
        Write-Warning "Error occurred while querying $computer."
        Continue
   }
   # Second for loop to get the actual output and info we want
   foreach ($Network in $Networks) {
    $IPAddress  = $Network.IpAddress[0]
    $SubnetMask  = $Network.IPSubnet[0]
    $DefaultGateway = $Network.DefaultIPGateway
    $DNSServers  = $Network.DNSServerSearchOrder
    $MACAddress  = $Network.MACAddress

    $OutputObj  = New-Object -Type PSObject
    $OutputObj | Add-Member -MemberType NoteProperty -Name ComputerName -Value $Computer.ToUpper()
    $OutputObj | Add-Member -MemberType NoteProperty -Name IPAddress -Value $IPAddress
    $OutputObj | Add-Member -MemberType NoteProperty -Name SubnetMask -Value $SubnetMask
    $OutputObj | Add-Member -MemberType NoteProperty -Name Gateway -Value "$DefaultGateway"
    $OutputObj | Add-Member -MemberType NoteProperty -Name DNSServers -Value "$DNSServers"
    $OutputObj | Add-Member -MemberType NoteProperty -Name MACAddress -Value $MACAddress
    # Finally, writes the output to a file (edit the path at the end)
    $OutputObj | Write-Output | Select-Object ComputerName, IPAddress, SubnetMask, Gateway, DNSServers, MACAddress | Export-Csv C:\support\NetworkInfo.csv -Append
   }
  }
 } 