#Get Computer List
$ComputerList = Import-CSV "C:\Users\nross\Documents\PCList1.csv" | Select-Object -ExpandProperty Name

#Reboot the computers
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
        shutdown /m $ComputerName /r /f /t 0
    } -ArgumentList $ComputerName
}