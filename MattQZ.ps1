﻿Invoke-Command -Computername B79MPC20 -Scriptblock { taskkill /F /IM javaw.exe; 'C:\Program Files\QZ Tray\qz-tray.exe' }