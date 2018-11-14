##############################################################################
#
#         This script will clear the User's Outlook Cache
#         Make sure NOT to run as admin!!! You have to run as the user 
#         otherwise HKCU will be your admin user.... :)
#
#         Created by: Nick Ross
#         Date: 11/1/2018
#
##############################################################################


#Find the Outlook Cache Folder
$Path = Get-ItemProperty -Path HKCU:\Software\Microsoft\Office\*\Outlook\Security | Select-Object -ExpandProperty OutlookSecureTempFolder

# Clear the cache of everything that has not been touched in the last 30 minutes 

Get-ChildItem -Path $Path | where {$_.Lastwritetime -gt (date).addminutes(-30)} | Remove-Item -Force -Recurse