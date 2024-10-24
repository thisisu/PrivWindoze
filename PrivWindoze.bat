:: PrivWindoze
:: Created by Furtivex
@echo OFF && color 17
title PrivWindoze by Furtivex - Version 1.3.9
ECHO(PrivWindoze by Furtivex - Version 1.3.9
ECHO.
ECHO.
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
cd /d %~dp0
COPY /y "%CD%\dependencies\sed.exe" %windir%\sed.exe >NUL 2>&1
COPY /y "%CD%\dependencies\grep.exe" %windir%\grep.exe >NUL 2>&1
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "QUICKLAUNCHALL=%appdata%\Microsoft\Internet Explorer\Quick Launch"
SET "PROGRAMS1ALL=%allusersprofile%\Start Menu\Programs"
SET "PROGRAMS2ALL=%userprofile%\Start Menu\Programs"
if exist "%windir%\Sysnative\cmd.exe" ( SET "SYS32=%windir%\Sysnative" ) else ( SET "SYS32=%windir%\System32" )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
if exist %windir%\syswow64 ( set ARCH=x64 ) else ( set ARCH=x86 )
if %ARCH%==x64 (
 SET "SYSWOW64=%windir%\SysWOW64"
)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "LOCALA=%localappdata%"
SET "LOCALLOW=%userprofile%\Appdata\LocalLow"
SET "PROGRAMS17=%allusersprofile%\Microsoft\Windows\Start Menu\Programs"
SET "PROGRAMS27=%appdata%\Microsoft\Windows\Start Menu\Programs"
SET "PUBDESKTOP=%systemdrive%\Users\Public\Desktop"
SET "QUICKLAUNCH17=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
SET "QUICKLAUNCH27=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
SET "STARTMENU17=%allusersprofile%\Microsoft\windows\Start Menu"
SET "STARTMENU27=%appdata%\Microsoft\Windows\Start Menu"
SET "STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
REM ~~~~~~~~~~~~~~~~~~~~~~~~>

:: Processes
:Processes
Echo([^|          ] Scanning Processes
IF NOT EXIST %SYS32%\taskkill.exe GOTO :Registry
for %%g in (
"Microsoft.SharePoint.exe"
"MicrosoftEdgeUpdate.exe"
"elevation_service.exe"
"msedge.exe"
) DO (
       TASKKILL /F /IM %%g >NUL 2>&1
      )
)

:: Registry
:Registry
Echo([^|^|         ] Scanning Registry
IF NOT EXIST %SYS32%\reg.exe GOTO :Tasks

IF %ARCH%==x64 (
                 for %%g in (
"HKCR\WOW6432Node\AppID\MicrosoftEdgeUpdate.exe"
"HKCR\WOW6432Node\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\WOW6432Node\Classes\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\WOW6432Node\Clients\StartMenuInternet\Microsoft Edge"
"HKLM\Software\WOW6432Node\Microsoft\Edge"
"HKLM\Software\WOW6432Node\Microsoft\EdgeUpdate"
"HKLM\Software\WOW6432Node\Microsoft\OneDrive"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive1"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive2"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive3"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive4"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive5"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive6"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive7"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\MicrosoftEdge"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
"HKLM\Software\WOW6432Node\Policies\Microsoft\Edge"
"HKLM\Software\WOW6432Node\Policies\Microsoft\MicrosoftEdge"
) DO (
      REG DELETE %%g /F >NUL 2>&1
      )
)

for %%g in (
"HKCR\AppID\MicrosoftEdgeUpdate.exe"
"HKCR\AppID\ie_to_edge_bho.dll"
"HKCR\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKCR\MSEdgeHTM"
"HKCR\MSEdgeMHT"
"HKCR\MSEdgePDF"
"HKCR\MicrosoftEdgeUpdate.CoreClass"
"HKCR\MicrosoftEdgeUpdate.CoreClass.1"
"HKCR\MicrosoftEdgeUpdate.CoreMachineClass"
"HKCR\MicrosoftEdgeUpdate.CoreMachineClass.1"
"HKCR\MicrosoftEdgeUpdate.CredentialDialogMachine"
"HKCR\MicrosoftEdgeUpdate.CredentialDialogMachine.1.0"
"HKCR\MicrosoftEdgeUpdate.OnDemandCOMClassMachine"
"HKCR\MicrosoftEdgeUpdate.OnDemandCOMClassMachine.1.0"
"HKCR\MicrosoftEdgeUpdate.OnDemandCOMClassMachineFallback"
"HKCR\MicrosoftEdgeUpdate.OnDemandCOMClassMachineFallback.1.0"
"HKCR\MicrosoftEdgeUpdate.OnDemandCOMClassSvc"
"HKCR\MicrosoftEdgeUpdate.OnDemandCOMClassSvc.1.0"
"HKCR\MicrosoftEdgeUpdate.PolicyStatusMachine"
"HKCR\MicrosoftEdgeUpdate.PolicyStatusMachine.1.0"
"HKCR\MicrosoftEdgeUpdate.PolicyStatusMachineFallback"
"HKCR\MicrosoftEdgeUpdate.PolicyStatusMachineFallback.1.0"
"HKCR\MicrosoftEdgeUpdate.PolicyStatusSvc"
"HKCR\MicrosoftEdgeUpdate.PolicyStatusSvc.1.0"
"HKCR\MicrosoftEdgeUpdate.ProcessLauncher"
"HKCR\MicrosoftEdgeUpdate.ProcessLauncher.1.0"
"HKCR\MicrosoftEdgeUpdate.Update3COMClassService"
"HKCR\MicrosoftEdgeUpdate.Update3COMClassService.1.0"
"HKCR\MicrosoftEdgeUpdate.Update3WebMachine"
"HKCR\MicrosoftEdgeUpdate.Update3WebMachine.1.0"
"HKCR\MicrosoftEdgeUpdate.Update3WebMachineFallback"
"HKCR\MicrosoftEdgeUpdate.Update3WebMachineFallback.1.0"
"HKCR\MicrosoftEdgeUpdate.Update3WebSvc"
"HKCR\MicrosoftEdgeUpdate.Update3WebSvc.1.0"
"HKCR\ie_to_edge_bho.IEToEdgeBHO"
"HKCR\ie_to_edge_bho.IEToEdgeBHO.1"
"HKCR\microsoft-edge"
"HKCR\microsoft-edge-holographic"
"HKCR\microsoftmusic"
"HKCR\microsoftvideo"
"HKCR\ms-xbet-survey"
"HKCR\xbox"
"HKCR\xbox-arena"
"HKCR\xbox-captures"
"HKCR\xbox-friendfinder"
"HKCR\xbox-gamehub"
"HKCR\xbox-lfg"
"HKCR\xbox-network"
"HKCR\xbox-profile"
"HKCR\xbox-settings"
"HKCR\xbox-store"
"HKCR\xbox-tcui"
"HKCR\xboxgames"
"HKCR\xboxidp"
"HKCR\xboxmusic"
"HKCU\Software\Classes\bingmaps"
"HKCU\Software\Classes\bingnews"
"HKCU\Software\Classes\bingweather"
"HKCU\Software\Classes\grvopen"
"HKCU\Software\Microsoft\Edge"
"HKCU\Software\Microsoft\EdgeUpdate"
"HKCU\Software\Microsoft\EdgeWebView"
"HKCU\Software\Microsoft\GameBar"
"HKCU\Software\Microsoft\GameBarApi"
"HKCU\Software\Microsoft\MicrosoftEdge"
"HKCU\Software\Microsoft\OneDrive"
"HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
"HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft OneDrive"
"HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\Teams"
"HKCU\Software\Microsoft\Xbox"
"HKCU\Software\Microsoft\XboxLive"
"HKLM\Software\Classes\AppID\{C5D3C0E1-DC41-4F83-8BA8-CC0D46BCCDE3}"
"HKLM\Software\Classes\CLSID\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Classes\MSEdgeHTM"
"HKLM\Software\Classes\MSEdgeMHT"
"HKLM\Software\Classes\MSEdgePDF"
"HKLM\Software\Clients\StartMenuInternet\Microsoft Edge"
"HKLM\Software\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}"
"HKLM\Software\Microsoft\MSN Apps\MSN Toolbar Suite"
"HKLM\Software\Microsoft\MicrosoftEdge"
"HKLM\Software\Microsoft\OneDrive"
"HKLM\Software\Microsoft\PolicyManager\default\TaskScheduler\EnableXboxGameSaveTask"
"HKLM\Software\Microsoft\TelemetryClient"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive1"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive2"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive3"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive4"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive5"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive6"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive7"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\OneDriveSetup.exe"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge WebView2 Runtime"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
"HKLM\Software\Microsoft\Windows\CurrentVersion\{A7AB73A3-CB10-4AA5-9D38-6AEFFBDE4C91}"
"HKLM\Software\Microsoft\Xbox"
"HKLM\Software\Policies\Microsoft\Windows\OneDrive"
"HKU\.DEFAULT\Software\Microsoft\Edge"
"HKU\.DEFAULT\Software\Microsoft\OneDrive"
"HKU\.DEFAULT\Software\Microsoft\TelemetryClient"
"HKU\.DEFAULT\Software\Microsoft\Windows Script\Settings\Telemetry"
"HKU\.DEFAULT\Software\Microsoft\Xbox"
"HKU\S-1-5-19\Software\Microsoft\OneDrive"
"HKU\S-1-5-20\Software\Microsoft\OneDrive"
"HKU\Software\Classes\feedback-hub"
"HKU\Software\Classes\insiderhub"
"HKU\Software\Classes\msnweather"
"HKU\Software\Microsoft\Edge"
"HKU\Software\Microsoft\GameBar"
"HKU\Software\Microsoft\GameBarApi"
"HKU\Software\Microsoft\OneDrive"
"HKU\Software\Microsoft\Xbox"
) DO (
       REG DELETE %%g /F >NUL 2>&1
      )
)

REM https://www.bleepingcomputer.com/forums/t/802105/3138awezipawezip-14360-x64-ffd303wmbhcj/
:: Solo Registry Value
Echo([^|^|^|        ] Scanning Solo Registry Values
REG DELETE "HKCR\.htm\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.html\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.mht\OpenWithProgids" /V MSEdgeMHT /F >NUL 2>&1
REG DELETE "HKCR\.pdf\OpenWithProgids" /V MSEdgePDF /F >NUL 2>&1
REG DELETE "HKCR\.shtml\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCU\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V OneDriveSetup /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V XboxStat /F >NUL 2>&1
REG DELETE "HKLM\Software\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE "HKLM\Software\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION" /V "OneDrive.exe" /F >NUL 2>&1
REG DELETE "HKLM\Software\WOW6432Node\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDriveSetup" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDriveSetup" /F >NUL 2>&1
REG DELETE "HKU\Software\Microsoft\Windows\CurrentVersion\Run" /V "Microsoft.Lists" /F >NUL 2>&1
REG DELETE "HKU\Software\Microsoft\Windows\CurrentVersion\Run" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDrive" /F >NUL 2>&1

:: Clear MUI Cache
REM HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache

:: Heuristic Registry Key
Echo([^|^|^|^|       ] Scanning Heur Registry Keys
IF NOT EXIST %SYS32%\findstr.exe GOTO :Policies
REG QUERY "HKCR"|FINDSTR -ri "^HKEY_CLASSES_ROOT\\xboxliveapp-">"%TEMP%\privwindozelog.txt"
IF NOT ERRORLEVEL 1 ( set xboxheur=true ) else ( set xboxheur=false )
REG QUERY "HKCR"|FINDSTR -ri "^HKEY_CLASSES_ROOT\\ms-xbl-">>"%TEMP%\privwindozelog.txt"
IF NOT ERRORLEVEL 1 ( set xboxheur=true ) else ( set xboxheur=false )

IF %xboxheur%==true (
    for /f %%g in (%TEMP%\privwindozelog.txt) DO (
         REG DELETE "%%g" /F >NUL 2>&1
        )
)

:: Heuristic Registry Value
:HeurValue
Echo([^|^|^|^|^|      ] Scanning Heur Registry Values
IF NOT EXIST %WINDIR%\sed.exe GOTO :Policies
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>NUL|FINDSTR -i "MicrosoftEdgeAutoLaunch_">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//g" <"%TEMP%\privwindozelog.txt" >"%TEMP%\privwindozelog2.txt"
for /f %%g in (%TEMP%\privwindozelog2.txt) DO (
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%g" /F >NUL 2>&1
)

REM HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall
:: Policies
:Policies
Echo([^|^|^|^|^|^|     ] Scanning Policies
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /T REG_DWORD /V ScoobeSystemSettingEnabled /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\System\AllowTelemetry" /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\WindowsAI\TurnOffWindowsCopilot" /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V AllowTelemetry /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V MaxTelemetryAllowed /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1


:: Tasks
:Tasks
Echo([^|^|^|^|^|^|^|    ] Scanning Tasks
REM Tasks creating new variants of themselves upon deletion? Little hard to prove at this point but will monitor (haha)
REM Yes, new tasks are formed, but I think this is due to the service being disabled as well. Upon disabling InstallService SVC, WakeUpAndContinueUpdates, and WakeUpAndScanForUpdates are created (but disabled)
IF NOT EXIST %SYS32%\schtasks.exe GOTO :Services
for %%g in (
"Microsoft\Windows\Application Experience\MareBackup"
"Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
"Microsoft\Windows\Application Experience\PcaPatchDbTask"
"Microsoft\Windows\Application Experience\PcaWallpaperAppDetect"
"Microsoft\Windows\Application Experience\SdbinstMergeDbTask"
"Microsoft\Windows\Application Experience\StartupAppTask"
"Microsoft\Windows\ApplicationData\DsSvcCleanup"
"Microsoft\Windows\ApplicationData\appuriverifierdaily"
"Microsoft\Windows\ApplicationData\appuriverifierinstall"
"Microsoft\Windows\Chkdsk\ProactiveScan"
"Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
"Microsoft\Windows\ConsentUX\UnifiedConsent\UnifiedConsentSyncTask"
"Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
"Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
"Microsoft\Windows\Defrag\ScheduledDefrag"
"Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner"
"Microsoft\Windows\Diagnosis\Scheduled"
"Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
"Microsoft\Windows\DiskFootprint\Diagnostics"
"Microsoft\Windows\DiskFootprint\StorageSense"
"Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask"
"Microsoft\Windows\Feedback\Siuf\DmClient"
"Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
"Microsoft\Windows\Flighting\FeatureConfig\BootstrapUsageDataReporting"
"Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures"
"Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing"
"Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting"
"Microsoft\Windows\Flighting\OneSettings\RefreshCache"
"Microsoft\Windows\InstallService\RestoreDevice"
"Microsoft\Windows\InstallService\ScanForUpdates"
"Microsoft\Windows\InstallService\ScanForUpdatesAsUser"
"Microsoft\Windows\InstallService\SmartRetry"
"Microsoft\Windows\InstallService\WakeUpAndContinueUpdates"
"Microsoft\Windows\InstallService\WakeUpAndScanForUpdates"
"Microsoft\Windows\Maintenance\WinSAT"
"Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
"Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
"Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
"Microsoft\Windows\PushToInstall\LoginCheck"
"Microsoft\Windows\PushToInstall\Registration"
"Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
"Microsoft\Windows\Shell\CreateObjectTask"
"Microsoft\Windows\Shell\FamilySafetyMonitor"
"Microsoft\Windows\Shell\FamilySafetyRefreshTask"
"Microsoft\Windows\Shell\IndexerAutomaticMaintenance"
"Microsoft\Windows\Shell\ThemesSyncedImageDownload"
"Microsoft\Windows\User Profile Service\HiveUploadTask"
"Microsoft\Windows\WlanSvc\CDSSync"
"Microsoft\Windows\WOF\WIM-Hash-Management"
"Microsoft\Windows\WOF\WIM-Hash-Validation"
"Microsoft\Windows\WwanSvc\NotificationTask"
"Microsoft\Windows\WwanSvc\OobeDiscovery"
"Microsoft\XblGameSave\XblGameSaveTask"
) DO (
       SCHTASKS /DELETE /TN %%g /F >NUL 2>&1
      )
)

dir /b "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^MicrosoftEdgeUpdateTask">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :OneDriveTask )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:OneDriveTask
dir /b "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^OneDrive">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :TelemetryTask )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:TelemetryTask
dir /b "%SYS32%\Tasks" 2>NUL|FINDSTR -i "Telemetry">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :NvidiaTask )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:NvidiaTask
dir /b "%SYS32%\Tasks" 2>NUL|FINDSTR -i "NvTmRep_">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :WindowsDefenderTask )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:WindowsDefenderTask
dir /b "%SYS32%\Tasks\Microsoft\Windows\Windows Defender" 2>NUL|FINDSTR -ri "^Windows Defender">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Services )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Microsoft\Windows\Windows Defender\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:: Services
:Services
Echo([^|^|^|^|^|^|^|^|   ] Scanning Services
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe GOTO :Services2
powershell -command "stop-service DiagTrack" >NUL 2>&1
powershell -command "stop-service DoSvc" >NUL 2>&1
powershell -command "stop-service InstallService" >NUL 2>&1
powershell -command "stop-service OneDrive Updater Service" >NUL 2>&1
powershell -command "stop-service MicrosoftEdgeElevationService" >NUL 2>&1
powershell -command "stop-service WpnService" >NUL 2>&1
powershell -command "stop-service XblAuthManager" >NUL 2>&1
powershell -command "stop-service XblGameSave" >NUL 2>&1
powershell -command "stop-service XboxGipSvc" >NUL 2>&1
powershell -command "stop-service XboxNetApiSvc" >NUL 2>&1
powershell -command "stop-service dmwappushservice" >NUL 2>&1
powershell -command "stop-service edgeupdate" >NUL 2>&1
powershell -command "stop-service edgeupdatem" >NUL 2>&1


powershell -command "set-service DiagTrack -startuptype disabled" >NUL 2>&1
powershell -command "set-service DoSvc -startuptype disabled" >NUL 2>&1
powershell -command "set-service InstallService -startuptype disabled" >NUL 2>&1
powershell -command "set-service OneDrive Updater Service -startuptype disabled" >NUL 2>&1
powershell -command "set-service WpnService -startuptype disabled" >NUL 2>&1
powershell -command "set-service XblAuthManager -startuptype disabled" >NUL 2>&1
powershell -command "set-service XblGameSave -startuptype disabled" >NUL 2>&1
powershell -command "set-service XboxGipSvc -startuptype disabled" >NUL 2>&1
powershell -command "set-service XboxNetApiSvc -startuptype disabled" >NUL 2>&1
powershell -command "set-service dmwappushservice -startuptype disabled" >NUL 2>&1
powershell -command "set-service edgeupdate -startuptype disabled" >NUL 2>&1
powershell -command "set-service edgeupdatem -startuptype disabled" >NUL 2>&1

GOTO :Services3

:Services2

IF NOT EXIST %SYS32%\sc.exe GOTO :Services3
sc config DiagTrack start= disabled>NUL
sc config DoSvc start= disabled>NUL
sc config InstallService start= disabled>NUL
sc config OneDrive Updater Service start= disabled>NUL
sc config WpnService start= disabled>NUL
sc config XblAuthManager start= disabled>NUL
sc config XblGameSave start= disabled>NUL
sc config XboxGipSvc start= disabled>NUL
sc config XboxNetApiSvc start= disabled>NUL
sc config dmwappushservice start= disabled>NUL
sc config edgeupdate start= disabled>NUL
sc config edgeupdatem start= disabled>NUL

:Services3
IF NOT EXIST %SYS32%\reg.exe GOTO :ServicesHuer
for %%g in (
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdate"
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdatem"
"HKLM\SYSTEM\CurrentControlSet\services\MicrosoftEdgeElevationService"
"HKLM\SYSTEM\CurrentControlSet\services\OneDrive Updater Service"
) DO (
       REG DELETE %%g /F >NUL 2>&1
      )
)

:ServicesHuer
IF NOT EXIST %SYS32%\reg.exe GOTO :DiscordFiles
IF NOT EXIST %WINDIR%\grep.exe GOTO :DiscordFiles
REM S2 edgeupdate1db0cab9f75c19; "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" /svc [X]
REM S3 edgeupdatem1db0cab9f91f3b; "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" /medsvc [X]
REG QUERY "HKLM\SYSTEM\CurrentControlSet\services" 2>NUL|GREP -Eis "\\edgeupdatem?[a-f0-9]{12,}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :DiscordFiles )
for /f %%g in (%TEMP%\privwindozelog.txt) DO (
    REG DELETE "%%g" /F >NUL 2>&1
)

:: Discord Files
:DiscordFiles
dir /b "%APPDATA%\discord\Code Cache\js" 2>NUL|FINDSTR -ri "^[a-f0-9].*_0$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Discord2 )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "discord=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Code Cache\js\!discord!" >NUL 2>&1
    ENDLOCAL
)

:Discord2
dir /b "%APPDATA%\discord\Cache\Cache_Data" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Files )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "discord=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Cache\Cache_Data\!discord!" >NUL 2>&1
    ENDLOCAL
)
:: Files
:Files
Echo([^|^|^|^|^|^|^|^|^|  ] Scanning Files
for %%g in (
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS17%\OneDrive.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PROGRAMS27%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%TEMP%\privwindozelog*.txt"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Favorites\Bing.url"
) DO (
       DEL /F/Q %%g >NUL 2>&1
      )
)

:: Folders
:Folders
Echo([^|^|^|^|^|^|^|^|^|^| ] Scanning Folders
for %%g in (
"%ALLUSERSPROFILE%\Microsoft OneDrive"
"%ALLUSERSPROFILE%\Microsoft\DiagnosticLogCSP"
"%ALLUSERSPROFILE%\Microsoft\EdgeUpdate"
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\XboxLive"
"%LOCALA%\OneDrive"
"%PROGRAMFILES%\Microsoft OneDrive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES(x86)%\Microsoft\Edge"
"%PROGRAMFILES(x86)%\Microsoft\EdgeCore"
"%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate"
"%PROGRAMFILES(x86)%\Microsoft\EdgeWebView"
"%SYS32%\Microsoft-Edge-WebView"
"%USERPROFILE%\MicrosoftEdgeBackups"
) DO (
      RD /S/Q %%g >NUL 2>&1
      )
)

:eof
Echo([^|^|^|^|^|^|^|^|^|^|^|] Script completed! Exiting in 3 seconds...
timeout /t 03>NUL