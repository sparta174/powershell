﻿#Elevate Privileges (Run as admin)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"C:\Users\*\Documents\TestNetFrameworkInstall.ps1`"" -Verb RunAs; exit }
