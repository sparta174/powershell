$QZ = 'C:\Program Files\QZ Tray\qztray.exe'

foreach($Computer in $ComputerList){
    Invoke-Command -ComputerName $Computer -ScriptBlock {Start-Process -FilePath C:\support\qztray.exe}
}

start 'C:\Program Files\QZ Tray\qz-tray.exe'