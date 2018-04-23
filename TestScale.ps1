$Scale = Invoke-RestMethod -Uri https://localhost:9000/api/scale?callback

# Check The Scale Service
if ($Scale = '("");'){
     # Restart the Service
     (Get-WMIObject Win32_Service -Filter "Name='GoldExchangeScale'").StopService()
     (Get-WMIObject Win32_Service -Filter "Name='GoldExchangeScale'").StartService()
     }
else {"Scale is working"}