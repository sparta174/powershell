#Get Computer List
$ComputerList = Import-CSV "C:\Users\*\Documents\testlistnetframework.csv" | Select-Object -ExpandProperty Name

#Install the .Net Framework
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ComputerName $ComputerName -ScriptBlock {
        Enable-WindowsOptionalFeature –Online –FeatureName NetFx3 –All 
    }
}
