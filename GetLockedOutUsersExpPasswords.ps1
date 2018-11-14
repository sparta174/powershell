################################################################
#
#  This script is to lookup all currently locked out users in AD  
#  and any users with Expired passwords. Then offers to unlock 
#  the user if you'd like.
#  Version 1
#  Created by: Nick Ross
#  Create Date: 11/5/2018
#
################################################################

Import-Module ActiveDirectory

$LockedOut = Search-ADAccount -LockedOut | FT Name, ObjectClass -AutoSize
$PassExpired = Search-ADAccount -PasswordExpired | FT Name, ObjectClass -AutoSize

if (-not [string]::IsNullOrEmpty($LockedOut) -Or -not [string]::IsNullOrEmpty($PassExpired)){
    Write-Output "Locked Out Users:" $LockedOut
    Write-Output "Expired Passwords:" $PassExpired
    $Unlock = Read-Host "Would you like to unlock? Y/N"
        if ($Unlock -eq "Y"){
            Search-ADAccount -LockedOut | Unlock-ADAccount -Confirm
            }
        else{
            Exit
            }
    }
else{
    Write-Output "No Users are locked or have expired Passwords! :)"
    }
