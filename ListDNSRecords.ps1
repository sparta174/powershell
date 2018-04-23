$DNSServer = "DC1"
$Zones = Get-DnsServerZone -ComputerName $DNSServer

ForEach ($Zone in $Zones) {
    Write-Host "`n$($Zone.ZoneName)" -ForeGroundColor "Green"
    $Results = $Zone | Get-DnsServerResourceRecord -ComputerName $DNSServer
    echo $Results > "$($Zone.ZoneName).txt"
    }