#Script to create folders en masse and copy the .jpg's with matching ID numbers to those folders

#Imports a list of numbers to filter for in the folder
$Folders = Import-csv C:\test\test1.csv
$FileType = '*.jpg'
 
#Variable declaration
ForEach ($Folder in $Folders) {
$FolderName = $Folder.Folder

# Create Folder
New-Item -path E:\LuxObsBackup -name $FolderName -itemtype directory
# Copy to newly created folder
    Get-ChildItem -Path E:\LuxObsBackup\*.jpg -Filter $FileType  -Recurse -Force |
    # Those '.jpg' file objects should be folders
    Where-Object {!$_.PSIsContainer} |
        # For each '.jpg' folder
        ForEach-Object {
        # Copy all '*.jpg' files in it to the destination folder
            Copy-Item -Path E:\LuxObsBackup\$FolderName*.jpg -Filter $FileType -Destination E:\LuxObsBackup\$FolderName -Force
        }
}