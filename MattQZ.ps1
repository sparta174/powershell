Invoke-Command -Computername * -Scriptblock { taskkill /F /IM javaw.exe; 'C:\Program Files\QZ Tray\qz-tray.exe' }
