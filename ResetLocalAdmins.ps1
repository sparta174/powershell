# Credentials for authenticating as domain admin
$UserName = "*";
$Password = ConvertTo-SecureString -String "*" -AsPlainText -Force;
$Credentials = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $UserName, $Password;

# Array of hosts that pass Test-Connection
$LiveHosts = @();

# Grab all workstations (not servers) from Active Directory, load into list
$WorkstationList += Get-ADComputer -Filter {OperatingSystem -NotLike "*Server*" -and name -like "*" -and enabled -eq "true"} -Property name;

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

# Do whatever to LiveHosts
foreach ($arwHost in $LiveHosts) {
    try {
        Write-Host $arwHost;
    } catch {
        
    }
}
