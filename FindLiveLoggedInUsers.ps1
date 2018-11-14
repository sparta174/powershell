################################################################
#
#  This script is to lookup all currently Live computers in AD  
#  then find which users are currently logged into them
#  Version 1
#  Created by: Nick Ross
#  Create Date: 11/5/2018
#
################################################################

# Array of hosts that pass Test-Connection
$LiveHosts = @();

# Grab all workstations (non-servers) from Active Directory, load into List
$WorkstationList += Get-ADComputer -Filter {OperatingSystem -NotLike "*Server*" -and enabled -eq "true"} -Property name;

# If hosts are returned, get total number of PCs
if ($WorkstationList.length -ne 0) {
    # Ping the PCs to see which ones are currently live
    foreach ($Host in $WorkstationList) {
        (New-Object System.Net.NetworkInformation.Ping).SendPingAsync($Host.Name);
        if ((New-Object System.Net.NetworkInformation.Ping).SendPingAsync($Host.Name).Result.Status -eq "Success") {
            $LiveHosts += $Host.Name;
            Write-Host "Live host count: " $LiveHosts.Count;
        }
    }
}

#Get Currently Logged in User from the host list generated above
foreach ($Computer in $LiveHosts) {
    Invoke-Command -ScriptBlock {
        $Username = Get-WMIObject -ComputerName $Computer -class Win32_ComputerSystem | select username
        Write-Host $Computer, $Username
    } -ArgumentList $Computer
}