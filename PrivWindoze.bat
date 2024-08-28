:: PrivWindoze
:: Created by Furtivex
@echo OFF && color 17
title PrivWindoze - Version 1.1.0
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
TASKKILL /F /IM "msedge.exe" >NUL 2>&1

:: Registry
IF NOT EXIST %SYS32%\reg.exe GOTO :Tasks

if %ARCH%==x64 (
                 for %%i in (
"HKCR\WOW6432Node\CLSID\{08D832B9-D2FD-481F-98CF-904D00DF63CC}"
"HKCR\WOW6432Node\CLSID\{2E1DD7EF-C12D-4F8E-8AD8-CF8CC265BAD0}"
"HKCR\WOW6432Node\CLSID\{492E1C30-A1A2-4695-87C8-7A8CAD6F936F}"
"HKCR\WOW6432Node\CLSID\{5F6A18BB-6231-424B-8242-19E5BB94F8ED}"
"HKCR\WOW6432Node\CLSID\{78DE489B-7931-4f14-83B4-C56D38AC9FFA}"
"HKCR\WOW6432Node\CLSID\{8F09CD6C-5964-4573-82E3-EBFF7702865B}"
"HKCR\WOW6432Node\CLSID\{A6B716CB-028B-404D-B72C-50E153DD68DA}"
"HKCR\WOW6432Node\CLSID\{B5977F34-9264-4AC3-9B31-1224827FF6E8}"
"HKCR\WOW6432Node\CLSID\{D1E8B1A6-32CE-443C-8E2E-EBA90C481353}"
"HKCR\WOW6432Node\CLSID\{E421557C-0628-43FB-BF2B-7C9F8A4D067C}"
"HKCR\WOW6432Node\CLSID\{EA92A799-267E-4DF5-A6ED-6A7E0684BB8A}"
"HKCR\WOW6432Node\CLSID\{FF419FF9-90BE-4D9F-B410-A789F90E5A7C}"
"HKLM\Software\Classes\AppID\{C5D3C0E1-DC41-4F83-8BA8-CC0D46BCCDE3}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{08D832B9-D2FD-481F-98CF-904D00DF63CC}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{2E1DD7EF-C12D-4F8E-8AD8-CF8CC265BAD0}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{492E1C30-A1A2-4695-87C8-7A8CAD6F936F}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{5F6A18BB-6231-424B-8242-19E5BB94F8ED}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{8F09CD6C-5964-4573-82E3-EBFF7702865B}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{A6B716CB-028B-404D-B72C-50E153DD68DA}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{B5977F34-9264-4AC3-9B31-1224827FF6E8}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{D1E8B1A6-32CE-443C-8E2E-EBA90C481353}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{E421557C-0628-43FB-BF2B-7C9F8A4D067C}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{EA92A799-267E-4DF5-A6ED-6A7E0684BB8A}"
"HKLM\Software\Classes\WOW6432Node\CLSID\{FF419FF9-90BE-4D9F-B410-A789F90E5A7C}"
"HKLM\Software\WOW6432Node\Clients\StartMenuInternet\Microsoft Edge"
"HKLM\Software\WOW6432Node\Microsoft\Edge"
"HKLM\Software\WOW6432Node\Microsoft\EdgeUpdate"
"HKLM\Software\WOW6432Node\Microsoft\OneDrive"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
"HKLM\Software\WOW6432Node\Policies\Microsoft\Edge"
"HKLM\Software\WOW6432Node\Policies\Microsoft\MicrosoftEdge"
) DO (
       REG DELETE %%i /F >NUL 2>&1
      )
)


for %%i in (
"HKCR\CLSID\{78DE489B-7931-4f14-83B4-C56D38AC9FFA}"
"HKCR\CLSID\{86C815AA-4888-4063-B0AB-03C49F788BE4}"
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
"HKCR\microsoft-edge"
"HKCR\microsoft-edge-holographic"
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
"HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
"HKCU\Software\Microsoft\Xbox"
"HKCU\Software\Microsoft\XboxLive"
"HKLM\Software\Classes\AppID\{C5D3C0E1-DC41-4F83-8BA8-CC0D46BCCDE3}"
"HKLM\Software\Classes\MSEdgeHTM"
"HKLM\Software\Classes\MSEdgeMHT"
"HKLM\Software\Classes\MSEdgePDF"
"HKLM\Software\Clients\StartMenuInternet\Microsoft Edge"
"HKLM\Software\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}"
"HKLM\Software\Microsoft\MSN Apps\MSN Toolbar Suite"
"HKLM\Software\Microsoft\MicrosoftEdge"
"HKLM\Software\Microsoft\OneDrive"
"HKLM\Software\Microsoft\PolicyManager\default\TaskScheduler\EnableXboxGameSaveTask"
"HKLM\Software\Microsoft\Xbox"
) DO (
       REG DELETE %%i /F >NUL 2>&1
      )
)

:: Solo Registry Value
REG DELETE "HKCU\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V "OneDriveSetup" /F >NUL 2>&1
REG DELETE "HKLM\Software\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE "HKLM\Software\WOW6432Node\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1


:: Heuristic Registry Key
IF NOT EXIST %SYS32%\findstr.exe GOTO :Policies
REG QUERY "HKCR"|FINDSTR /i "xboxliveapp-">"%TEMP%\trash3.txt"
IF %ERRORLEVEL% EQU 1 ( GOTO :HeurValue )
for /f "usebackq delims=" %%i in ("%TEMP%\trash3.txt") DO (
    REG DELETE "%%i" /F >NUL 2>&1
)


:: Heuristic Registry Value
:HeurValue
IF NOT EXIST %WINDIR%\sed.exe GOTO :Policies
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"|FINDSTR /i "MicrosoftEdgeAutoLaunch">"%TEMP%\trash.txt"
IF %ERRORLEVEL% EQU 1 ( GOTO :Policies )
SED -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//g" <"%TEMP%\trash.txt" >"%TEMP%\trash2.txt"
for /f "usebackq delims=" %%i in ("%TEMP%\trash2.txt") DO (
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%i" /F >NUL 2>&1
)

:: Policies
:Policies
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\System\AllowTelemetry" /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\WindowsAI\TurnOffWindowsCopilot" /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V AllowTelemetry /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V MaxTelemetryAllowed /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1

:: Tasks
:Tasks
IF NOT EXIST %SYS32%\schtasks.exe GOTO :Services
for %%i in (
"MicrosoftEdgeUpdateTaskMachineCore"
"MicrosoftEdgeUpdateTaskMachineUA"
"Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
"Microsoft\Windows\Maintenance\WinSAT"
"Microsoft\XblGameSave"
"Microsoft\XblGameSave\XblGameSaveTask"
"Microsoft\Windows\Application Experience\MareBackup"
"Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
"Microsoft\Windows\Application Experience\PcaPatchDbTask"
"Microsoft\Windows\Application Experience\PcaWallpaperAppDetect"
"Microsoft\Windows\Application Experience\SdbinstMergeDbTask"
"Microsoft\Windows\Application Experience\StartupAppTask"
"Microsoft\Windows\Feedback\Siuf\DmClient"
"Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
) DO (
       SCHTASKS /DELETE /TN %%i /F >NUL 2>&1
      )
)

dir /b "%SYS32%\Tasks"|findstr /i "microsoftedgeupdate">"%TEMP%\trash4.txt"
IF %ERRORLEVEL% EQU 1 ( GOTO :OneDriveTask )
for /f "usebackq delims=" %%i in ("%TEMP%\trash4.txt") DO (
    SCHTASKS /DELETE /TN "%%i" /F >NUL 2>&1
    DEL /F/Q "%SYS32%\Tasks\%%i" >NUL 2>&1
    DEL /F/Q "%SYS32%\Tasks_Migrated\%%i" >NUL 2>&1
)
:OneDriveTask
dir /b "%SYS32%\Tasks"|findstr /i "OneDrive Standalone Update Task">"%TEMP%\trash5.txt"
IF %ERRORLEVEL% EQU 1 ( GOTO :Services )
for /f "usebackq delims=" %%i in ("%TEMP%\trash5.txt") DO (
    SCHTASKS /DELETE /TN "%%i" /F >NUL 2>&1
    DEL /F/Q "%SYS32%\Tasks\%%i" >NUL 2>&1
    DEL /F/Q "%SYS32%\Tasks_Migrated\%%i" >NUL 2>&1
)

:: Services
:Services
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

powershell -command "set-service DiagTrack -startuptype disabled"
powershell -command "set-service dmwappushservice -startuptype disabled"
powershell -command "set-service XboxGipSvc -startuptype disabled"
powershell -command "set-service XblAuthManager -startuptype disabled"
powershell -command "set-service XblGameSave -startuptype disabled"
powershell -command "set-service XboxNetApiSvc -startuptype disabled"

goto :Files

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
for %%i in (
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdate"
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdatem"
"HKLM\SYSTEM\CurrentControlSet\services\MicrosoftEdgeElevationService"
) DO (
       REG DELETE %%i /F >NUL 2>&1
      )
)

:: Files
:Files
for %%i in (
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%TEMP%\trash*.txt"
) DO (
       DEL /F/Q %%i >NUL 2>&1
      )
)

:: Folders
for %%i in (
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\XboxLive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES(x86)%\Microsoft\Edge"
"%PROGRAMFILES(x86)%\Microsoft\EdgeCore"
"%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate"
"%PROGRAMFILES(x86)%\Microsoft\EdgeWebView"
"%USERPROFILE%\MicrosoftEdgeBackups"
) DO (
      RD /S/Q %%i >NUL 2>&1
      )
)

:eof