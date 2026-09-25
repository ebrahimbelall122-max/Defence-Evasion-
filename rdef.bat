@echo off
echo ===================================================
echo   إعادة تفعيل كافة خدمات وسياسات أمان Windows Defender
echo ===================================================

rem 1 - إعادة تفعيل خدمات الأمان الأساسية ومحركات النواة (الاستعادة لوضع الإقلاع التلقائي)
reg add "HKLM\System\CurrentControlSet\Services\WdBoot" /v "Start" /t REG_DWORD /d "0" /f
reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "0" /f
reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "3" /f
reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "3" /f
reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "2" /f

rem 2 - حذف سياسات التعطيل الشامل من السجل ليعود المحرك للعمل تلقائياً
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /f

rem 3 - إعادة تفعيل مسجلات الأحداث (Logging) لتتبع العمليات الأمنية
reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "1" /f
reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "1" /f

rem 4 - إعادة تفعيل كافة المهام المجدولة الافتراضية للفحص والصيانة
schtasks /Change /TN "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /Enable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Enable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Enable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Enable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Enable

rem 5 - إعادة تشغيل الحماية الفورية عبر PowerShell لضمان التطبيق الفوري
powershell.exe Set-MpPreference -DisableRealtimeMonitoring $false
powershell.exe Set-MpPreference -DisableBehaviorMonitoring $false
powershell.exe Set-MpPreference -DisableIOAVProtection $false

echo ===================================================
echo   تمت استعادة الإعدادات بنجاح. يرجى إعادة تشغيل الجهاز.
echo ===================================================
