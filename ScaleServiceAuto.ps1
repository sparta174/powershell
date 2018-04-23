# Get Computer List
$ComputerList = Import-CSV "\\B79FS\Apps\ITDocs\Powershell Scripts\TestList4.csv" | Select-Object -ExpandProperty Name
$Username = "Beyond79\Administrator"
$Password = cat '\\B79FS\Apps\ITDocs\Powershell Scripts\securefile.txt' | ConvertTo-SecureString
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $Password

foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
    Enter-PSSession $ComputerName
    $Scale = Invoke-RestMethod -Uri https://localhost:9000/api/scale?callback
        # Check The Scale Service
        if ($Scale = '("ST,+????????dwt");'){
            # Restart the Service
                (Get-WMIObject -computerName $ComputerName Win32_Service -Filter "Name='GoldExchangeScale'").StopService()
                (Get-WMIObject -computerName $ComputerName Win32_Service -Filter "Name='GoldExchangeScale'").StartService()
                Exit-PSSession
            }
        else{Exit-PSSession}
        }
    }