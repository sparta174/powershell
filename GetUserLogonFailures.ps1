$DC = Get-ADDomainController -Filter *
$Date = (Get-Date).AddDays(-1)
$User = Read-Host "Which User?"

foreach($D in $DC) {
    Get-EventLog -LogName Security -After $Date -ComputerName $D -Message *$User* | Where { $_.EventID -eq 4625 }
}


Get-EventLog -LogName Security -After (Get-Date).AddDays(-1) -ComputerName HS1DCHQ01 -Message *carimbocasi* | Where { $_.EventID -eq 4625 }