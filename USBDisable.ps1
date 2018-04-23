#Get Computer List
$ComputerList = Import-CSV '\\B79fs\Apps\ITDocs\Powershell Scripts\PCListProcessing.csv' | Select-Object -ExpandProperty Name

#Adjust the Registry settings
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
        CMD /C "sc \\$ComputerName config RemoteRegistry start=auto"
        CMD /C "REG ADD \\$ComputerName\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsbStor /v Start /t REG_DWORD /d 4 /f"
    } -ArgumentList $ComputerName
}