# Array of hosts that pass Test-Connection
$LiveHosts = @();

# Grab all workstations (non-servers) from Active Directory, load into List
$WorkstationList += Get-ADComputer -Filter {OperatingSystem -NotLike "*Server*" -and name -like "ARW*" -and enabled -eq "true"} -Property name;

# If hosts are returned, get total number of PCs
if ($WorkstationList.length -ne 0) {
    foreach ($arwHost in $WorkstationList) {
        (New-Object System.Net.NetworkInformation.Ping).SendPingAsync($arwHost.Name);
        if ((New-Object System.Net.NetworkInformation.Ping).SendPingAsync($arwHost.Name).Result.Status -eq "Success") {
            $LiveHosts += $arwHost.Name;
            Write-Host "Live host count: " $LiveHosts.Count;
        }
    }
}