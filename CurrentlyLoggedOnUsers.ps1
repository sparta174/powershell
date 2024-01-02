#Get Computer List
$ComputerList = Import-CSV "*" | Select-Object -ExpandProperty Name


#Get Currently Logged in User
foreach ($ComputerName in $ComputerList) {
    Invoke-Command -ScriptBlock {
        $Username = Get-WMIObject -ComputerName $ComputerName -class Win32_ComputerSystem | select username
        Write-Host $ComputerName, $Username
    } -ArgumentList $ComputerName
}
