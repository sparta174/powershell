##################################################################
#
#     This script will check for a scan folder
#     If it exists, it will set permissions (if needed)
#     If it does not exist, it will create and set permissions
#
##################################################################


Import-Module ActiveDirectory
#Path to the Scans folder (commented out for testing purposes)
$Path = 'Path to share'

#User to create the folder for
$UserFN = Read-Host "Input user's first name"
$UserLN = Read-Host "Input user's last name"
$UserName = $UserFN + $UserLN
$ADUserName = $UserLN + $UserFN[0]

# Create the full path with user's name
$NewPath = $Path + $UserName

# Verify the info
Write-Host "Creating Scan folder for " $UserName
Write-Host $NewPath 
$Confirm = Read-Host "Is this Information Correct? (Y/N)" 

# User confirms and double-check the AD to make sure the user exists
If($Confirm = "y"){

    Try{
        # Check AD
        $ADUser = Get-ADUser -Identity $ADUserName -ErrorAction Stop
        }
    Catch{
        # User doesn't exist in AD
        Write-Warning -Message "Could not find user " + $ADUserName + ". Please check spelling and try again"
        }
}
Else{
    Write-Host "Please try again."
    Stop
}

# Try to create the new folder if the folder Exists, skip and keep going
Try{
    New-Item $NewPath -ItemType Directory
}
Catch{
    Write-Output "Folder exists. Moving forward..."
}


# Disable Inheritance on folder
ICACLS $NewPath /inheritance:d

# Find the ACL and set variable
$ACL = Get-Acl $NewPath

# Variables to ADD the necessary permissions
$ACLFullControl = New-Object System.Security.AccessControl.FileSystemAccessRule @($ADUserName, "FullControl", "Allow")
$ACLAdminFC = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToAdd", "FullControl", "Allow")
$ACLSysFC = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToAdd", "FullControl", "Allow")
$ACLScanFC = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToAdd", "FullControl", "Allow")

# Variables to REMOVE pre-inherited permissions
$ACLRem1 = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToRemove", "FullControl", "Deny")
$ACLRem2 = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToRemove", "FullControl", "Deny")
$ACLRem3 = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToRemove", "FullControl", "Deny")
$ACLRem4 = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToRemove", "ReadAndExecute", "Allow")
$ACLRem5 = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToRemove", "ReadAndExecute", "Allow")
$ACLRem6 = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToRemove", "FullControl", "Allow")
$ACLRem7 = New-Object System.Security.AccessControl.FileSystemAccessRule @("PermissionToRemove", "Modify", "Allow")

# Add the Access Rules to the ACL
$ACL.SetAccessRule($ACLFullControl)
$ACL.SetAccessRule($ACLAdminFC)
$ACL.SetAccessRule($ACLSysFC)
$ACL.SetAccessRule($ACLScanFC)

# REMOVE the Access Rules from the ACL
$ACL.RemoveAccessRuleAll($ACLRem1)
$ACL.RemoveAccessRuleAll($ACLRem2)
$ACL.RemoveAccessRuleAll($ACLRem3)
$ACL.RemoveAccessRuleAll($ACLRem4)
$ACL.RemoveAccessRuleAll($ACLRem5)
$ACL.RemoveAccessRuleAll($ACLRem6)
$ACL.RemoveAccessRuleAll($ACLRem7)


# Officially Set the ACL to the folder
Set-Acl $NewPath $ACL

# ....and we're done :)
Write-Host "Scan folder has been created and permissioned properly for" $UserFN $UserLN
