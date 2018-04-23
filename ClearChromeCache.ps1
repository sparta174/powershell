#Get Computer List
$ComputerList = Import-CSV "C:\Users\nross\Documents\PCList1.csv" | Select-Object -ExpandProperty Name

#Clear the Chrome cache
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
        Remove-Item '\\$ComputerName\Users\ChromeCache\*' -Recurse
    } -ArgumentList $ComputerName
}