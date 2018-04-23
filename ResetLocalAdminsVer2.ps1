# This script will allow you to change admin passwords for all "live" hosts on the network at the time of run
# It will prompt you for your credentials, check if you're able to run this script, ask for the new password, 
# then do it's business.
#
# Enjoy!!!!
###############################################################################################################


# Credentials for Domain Admin (to make sure you have the rights to do this)

$Credentials = Get-Credential -Message "All passwords are belong to us..."
    $UserName = $Credentials.username
    $Password = $Credentials.GetNetworkCredential().Password

# Test Credentials against AD
$CurrentDomain = "LDAP://" + ([ADSI]"").distinguishedName
$Domain = New-Object System.DirectoryServices.DirectoryEntry($CurrentDomain, $UserName, $Password)

if ($Domain.Name -eq $null) {
    Write-Host "Authentication Failed - Please turn yourself in to the proper authorities at the nearest kiosk."
    Exit }
else {
    Write-Host "Authentication Successful. Please continue."
    }

# Import the CSV with the PCs to change the passwords for
 $ComputerList = Import-Csv "C:\Stuffs\ARWListChunk7.csv" | Select-Object -ExpandProperty Name

# Get Password to change local admin password to
$Pass = Read-Host -AsSecureString

# Parse the computer list and change the passwords
foreach ($Computer in $ComputerList) {
    Invoke-Command -ComputerName $Computer -Credential $Credentials -ScriptBlock {
     param($Pass)
     Set-LocalUser -Name admin -Password $Pass
     } -ArgumentList $Pass
}

Write-Host "You have successfully stolen the network. Congratulations!"

# BlueRightDown74!