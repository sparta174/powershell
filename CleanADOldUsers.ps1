# Clean AD script

$Days = # However many days you'd like to look back

# Will look for users that are "Modified" (disabled) and disabled within the last however many days you'd like 
Get-ADUser -Filter {(Modified -ge $Days) -and (Enabled -eq $False) -and (LastLogonDate -ge $Days} -Properties LastLogonDate, PasswordLastSet | Select-Object Name, LastLogonDate, PasswordLastSet