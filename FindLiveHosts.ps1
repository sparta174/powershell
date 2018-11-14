# Array of hosts that pass Test-Connection
$LiveHosts = @();

# Grab all workstations (non-servers) from Active Directory, load into List
$WorkstationList += Get-ADComputer -Filter {OperatingSystem -NotLike "*Server*" -and enabled -eq "true"} -Property name;

# If hosts are returned, get total number of PCs
if ($WorkstationList.length -ne 0) {
    foreach ($Host in $WorkstationList) {
        (New-Object System.Net.NetworkInformation.Ping).SendPingAsync($Host.Name);
        if ((New-Object System.Net.NetworkInformation.Ping).SendPingAsync($Host.Name).Result.Status -eq "Success") {
            $LiveHosts += $Host.Name;
            Write-Host "Live host count: " $LiveHosts.Count;
        }
    }
}

