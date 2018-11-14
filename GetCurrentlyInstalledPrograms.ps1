############################################################
#
#  This script is to get a list of installed programs for  
#  computers of a list you input into it
#  Version 1
#  Created by: Nick Ross
#  Create Date: 11/5/2018
#
############################################################

# Import the PC List
$ComputerList = Import-CSV C:\support\PCList1.csv | Select-Object -ExpandProperty Name

# Create the for loop and invoke the command to pull the data
foreach($Computer in $ComputerList){
    Invoke-Command -ComputerName $ComputerList -ScriptBlock {
        Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, Publisher, InstallDate, PSComputerName
        }
}
