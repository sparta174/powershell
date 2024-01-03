#Get Computer List

#$ComputerList = Import-CSV "C:\Stuffs\*.csv" | Select-Object -ExpandProperty Name
#$HostList = @()
#$IPs = [System.Net.Dns]::GetHostAddresses($ComputerList)
#[System.Net.Dns]::GetHostAddresses($ComputerList) | foreach {echo $_.IPAddressToString }

#Get Currently Logged in User
foreach ($Hosts in $LiveHosts) {
    Invoke-Command -ScriptBlock {
        #[System.Net.Dns]::GetHostAddresses($Computer)| foreach {echo $_.IPAddressToString }
        Get-WMIObject -ComputerName $Hosts -class Win32_ComputerSystem |  Select username, name | Format-Table
    } -ArgumentList $ComputerName
}

