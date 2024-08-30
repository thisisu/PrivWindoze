:: PrivWindoze
:: Created by Furtivex
@echo OFF && color 17
title PrivWindoze by Furtivex - Version 1.1.5
ECHO(PrivWindoze by Furtivex - Version 1.1.5
ECHO.
ECHO.
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

:: Processes
Echo([^|          ] Scanning Processes
TASKKILL /F /IM "msedge.exe" >NUL 2>&1

:: Registry
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
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Microsoft\Xbox"
"HKLM\Software\Policies\Microsoft\Windows\OneDrive"
) DO (
       REG DELETE %%g /F >NUL 2>&1
      )
)

:: Solo Registry Value
Echo([^|^|^|        ] Scanning Solo Registry Values
REG DELETE "HKCU\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V OneDriveSetup /F >NUL 2>&1
REG DELETE "HKLM\Software\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE "HKLM\Software\WOW6432Node\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V XboxStat /F >NUL 2>&1


:: Heuristic Registry Key
Echo([^|^|^|^|       ] Scanning Heur Registry Keys
IF NOT EXIST %SYS32%\findstr.exe GOTO :Policies
REG QUERY "HKCR"|FINDSTR -ri "^HKEY_CLASSES_ROOT\\xboxliveapp-">"%TEMP%\trash3.txt"
IF NOT ERRORLEVEL 1 ( set xboxheur=true ) else ( set xboxheur=false )
REG QUERY "HKCR"|FINDSTR -ri "^HKEY_CLASSES_ROOT\\ms-xbl-">>"%TEMP%\trash3.txt"
IF NOT ERRORLEVEL 1 ( set xboxheur=true ) else ( set xboxheur=false )

IF %xboxheur%==true (
    for /f %%g in (%TEMP%\trash3.txt) DO (
         REG DELETE "%%g" /F >NUL 2>&1
        )
)

:: Heuristic Registry Value
:HeurValue
Echo([^|^|^|^|^|      ] Scanning Heur Registry Values
IF NOT EXIST %WINDIR%\sed.exe GOTO :Policies
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"|FINDSTR -i "MicrosoftEdgeAutoLaunch_">"%TEMP%\trash.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//g" <"%TEMP%\trash.txt" >"%TEMP%\trash2.txt"
for /f %%g in (%TEMP%\trash2.txt) DO (
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%g" /F >NUL 2>&1
)

:: Policies
:Policies
Echo([^|^|^|^|^|^|     ] Scanning Policies
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
IF NOT EXIST %SYS32%\schtasks.exe GOTO :Services
for %%g in (
"Microsoft\Windows\Application Experience\MareBackup"
"Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
"Microsoft\Windows\Application Experience\PcaPatchDbTask"
"Microsoft\Windows\Application Experience\PcaWallpaperAppDetect"
"Microsoft\Windows\Application Experience\SdbinstMergeDbTask"
"Microsoft\Windows\Application Experience\StartupAppTask"
"Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
"Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
"Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
"Microsoft\Windows\Feedback\Siuf\DmClient"
"Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
"Microsoft\Windows\Maintenance\WinSAT"
"Microsoft\XblGameSave"
"Microsoft\XblGameSave\XblGameSaveTask"
) DO (
       SCHTASKS /DELETE /TN %%g /F >NUL 2>&1
      )
)

dir /b "%SYS32%\Tasks"|FINDSTR -ri "^MicrosoftEdgeUpdateTask">"%TEMP%\trash4.txt"
IF ERRORLEVEL 1 ( GOTO :OneDriveTask )
for /f "usebackq delims=" %%g in ("%TEMP%\trash4.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:OneDriveTask
dir /b "%SYS32%\Tasks"|FINDSTR -ri "^OneDrive">"%TEMP%\trash5.txt"
IF ERRORLEVEL 1 ( GOTO :TelemetryTask )
for /f "usebackq delims=" %%g in ("%TEMP%\trash5.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:TelemetryTask
dir /b "%SYS32%\Tasks"|FINDSTR -i "Telemetry">"%TEMP%\trash6.txt"
IF ERRORLEVEL 1 ( GOTO :Services )
for /f "usebackq delims=" %%g in ("%TEMP%\trash6.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)

:: Services
:Services
Echo([^|^|^|^|^|^|^|^|   ] Scanning Services
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe GOTO :Services2
powershell -command "stop-service DiagTrack" >NUL 2>&1
powershell -command "stop-service dmwappushservice" >NUL 2>&1
powershell -command "stop-service edgeupdate" >NUL 2>&1
powershell -command "stop-service edgeupdatem" >NUL 2>&1
powershell -command "stop-service MicrosoftEdgeElevationService" >NUL 2>&1
powershell -command "stop-service XboxGipSvc" >NUL 2>&1
powershell -command "stop-service XblAuthManager" >NUL 2>&1
powershell -command "stop-service XblGameSave" >NUL 2>&1
powershell -command "stop-service XboxNetApiSvc" >NUL 2>&1

powershell -command "set-service DiagTrack -startuptype disabled" >NUL 2>&1
powershell -command "set-service dmwappushservice -startuptype disabled" >NUL 2>&1
powershell -command "set-service XboxGipSvc -startuptype disabled" >NUL 2>&1
powershell -command "set-service XblAuthManager -startuptype disabled" >NUL 2>&1
powershell -command "set-service XblGameSave -startuptype disabled" >NUL 2>&1
powershell -command "set-service XboxNetApiSvc -startuptype disabled" >NUL 2>&1


:Services2
IF NOT EXIST %SYS32%\sc.exe GOTO :Services3
sc config DiagTrack start= disabled>NUL
sc config dmwappushservice start= disabled>NUL
sc config XboxGipSvc start= disabled>NUL
sc config XblAuthManager start= disabled>NUL
sc config XblGameSave start= disabled>NUL
sc config XboxNetApiSvc start= disabled>NUL

:Services3
IF NOT EXIST %SYS32%\reg.exe GOTO :Files
for %%g in (
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdate"
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdatem"
"HKLM\SYSTEM\CurrentControlSet\services\MicrosoftEdgeElevationService"
) DO (
       REG DELETE %%g /F >NUL 2>&1
      )
)

:: Files
:Files
Echo([^|^|^|^|^|^|^|^|^|  ] Scanning Files
for %%g in (
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PROGRAMS27%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%TEMP%\trash*.txt"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Favorites\Bing.url"
) DO (
       DEL /F/Q %%g >NUL 2>&1
      )
)

:: Folders
Echo([^|^|^|^|^|^|^|^|^|^| ] Scanning Folders
for %%g in (
"%ALLUSERSPROFILE%\Microsoft OneDrive"
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\XboxLive"
"%LOCALA%\OneDrive"
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
EXIT