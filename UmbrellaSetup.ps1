#Prompt for Username
$User = Read-Host -Prompt 'Input User Name'

#Get Computer List
$ComputerList = Import-CSV "\\Mac\Home\Documents\Powershell Scripts\PCList1.csv" | Select-Object -ExpandProperty Name


#Get Currently Logged in User
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
        $Username = Get-WMIObject -ComputerName $ComputerName -class Win32_ComputerSystem | select username | Select-String -Pattern $User 
        Write-Host $Username | Select-String -Pattern $User
    } -ArgumentList $ComputerName
}