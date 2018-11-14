#########################################################
#
#  This script is to lookup Powershell and .Net versions
#  for a list of PCs
#  Version 1
#  Created by: Nick Ross
#  Create Date: 11/2/2018
#
#########################################################

#Get Computer List
$ComputerList = Import-CSV C:\support\PCList1.csv | Select-Object -ExpandProperty Name


# Look Up the Powershell Version foreach computer in the list above
foreach ($ComputerName in $ComputerList){
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            $PSVersionTable.PSVersion | Select-Object PSComputerName, Major, Minor
            Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
                Get-ItemProperty -name Version,Release -EA 0 |
                Where { $_.PSChildName -match '^(?!S)\p{L}'} |
                Select PSChildName, Version, Release
        } | Select-Object PSComputerName, Major, PSChildName, Version, Release | Export-Csv C:\support\PCinfo.csv -Append
    
}