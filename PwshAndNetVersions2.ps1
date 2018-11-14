$PwshVersion = $PSVersionTable.PSVersion
$NetVersion = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
            Get-ItemProperty -name Version,Release -EA 0 |
            Where { $_.PSChildName -match '^(?!S)\p{L}'} |
            Select PSChildName, Version, Release
$ComputerName = Get-Content C:\support\PCList1.csv



$ServerInfo = Invoke-Command -ComputerName ($ComputerName) -ScriptBlock {
    $PwshVersion 
    $NetVersion
    Write-Output $ServerInfo
    }

$ServerInfo | Format-Table | Write-Output