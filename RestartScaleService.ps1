# Get Computer List
$ComputerList = Import-CSV "\\*\Apps\ITDocs\Powershell Scripts\TestList4.csv" | Select-Object -ExpandProperty Name

# Check The Scale Service
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
        # API Call to test scale
            https://localhost:9000/api/scale?callback
        # Restart the Service
        (Get-WMIObject -computerName $ComputerName Win32_Service -Filter "Name='GoldExchangeScale'").StopService()
        (Get-WMIObject -computerName $ComputerName Win32_Service -Filter "Name='GoldExchangeScale'").StartService()
    } -ArgumentList $ComputerName
}
