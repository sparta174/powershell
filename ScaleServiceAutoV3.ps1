# Get Computer List
$ComputerList = Import-CSV "\\B79FS\Apps\ITDocs\Powershell Scripts\TestList4.csv" | Select-Object -ExpandProperty Name

foreach($Computer in $ComputerList){
Invoke-Command -FilePath '\\B79FS\Apps\ITDOCS\Powershell Scripts\TestScale.ps1' -ComputerName $Computer
}