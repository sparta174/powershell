#Get Computer List
$ComputerList = Import-CSV C:\support\PCList1.csv | Select-Object -ExpandProperty Name



#Clear the Chrome cache
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
        Get-ChildItem -Path "\\$ComputerName\Users\*\AppData\Local\Google\Chrome\User Data\Default\Cache\*" | where {$_.Lastwritetime -lt (date).addminutes(-30)} | Remove-Item -Force -Recurse -Exclude index, data*
        Get-ChildItem -Path "\\$ComputerName\Users\*\AppData\Local\Google\Chrome\User Data\Profile 1\Cache\*" | where {$_.Lastwritetime -lt (date).addminutes(-30)} | Remove-Item -Force -Recurse -Exclude index, data*
    } -ArgumentList $ComputerName
}