:: PrivWindoze
:: Created by Furtivex
@echo OFF && color 17
title PrivWindoze by Furtivex - Version 2.0.1
ECHO(PrivWindoze by Furtivex - Version 2.0.1
ECHO.
ECHO.
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
cd /d %~dp0
for %%g in (
grep.exe
libiconv2.dll
libintl3.dll
nircmd.exe
pcre3.dll
regex2.dll
sed.exe
sort_.exe
) DO (
COPY /Y "%CD%\dependencies\%%g" "%WINDIR%" >NUL 2>&1
)
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
Echo([^|     ] Scanning Processes
IF NOT EXIST %SYS32%\taskkill.exe GOTO :WindowsApps
for %%g in (
"FileCoAuth.exe"
"FileSyncHelper.exe"
"Microsoft.Media.Player.exe"
"Microsoft.SharePoint.exe"
"MicrosoftEdgeUpdate.exe"
"OneDrive.exe"
"OneDriveUpdaterService.exe"
"Teams.exe"
"Widgets.exe"
"elevation_service.exe"
"ms-teams.exe"
"msedge.exe"
"msedgewebview2.exe"
) DO (
       TASKKILL /F /IM %%g >NUL 2>&1
      )
)
:: Windows Apps
:WindowsApps
Echo([^|^|    ] Scanning Windows Apps
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe GOTO :Registry
IF NOT EXIST %windir%\grep.exe GOTO :Registry
IF NOT EXIST %windir%\sed.exe GOTO :Registry
powershell -command "Get-AppxPackage -AllUsers | Format-List -Property PackageFullName">"%temp%\privwindozelog.txt"
GREP -Eis " : (Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)| : (acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|WildTangentGames))" <"%temp%\privwindozelog.txt" >"%temp%\privwindozelog2.txt"
IF NOT ERRORLEVEL 1 ( set dumbapps=true ) else ( set dumbapps=false )
IF %dumbapps%==true (
sed -r "s/^PackageFullName : //" <"%temp%\privwindozelog2.txt" >"%temp%\privwindozelog3.txt"
)
IF %dumbapps%==true (
    for /f %%g in (%TEMP%\privwindozelog3.txt) DO (
         powershell -command "Remove-AppxPackage -AllUsers -Package %%g" >NUL 2>&1
        )
)
REM B9ECED6F = Asus bundles
REM AD2F1837 = HP Bundles
REM 549981C3F5F10 = MS Cortana
REM 9426MICRO = MSI // Micro Star International Bundles
:: Registry
:Registry
Echo([^|^|^|   ] Scanning Registry
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
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive1"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive2"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive3"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive4"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive5"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive6"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive7"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\MicrosoftEdge"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{1F2B6AF3-C260-8666-5950-E3FEDBC851D6}"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{39AF0813-FA7B-4860-ADBE-93B9B214B914}"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{731F6BAA-A986-45A4-8936-7C3AAAAA760B}"
"HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{DF8C4194-1791-41CC-A455-8EBCCF084366}"
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
"HKCR\\msnnews"
"HKCR\ie_to_edge_bho.IEToEdgeBHO"
"HKCR\ie_to_edge_bho.IEToEdgeBHO.1"
"HKCR\microsoft-edge"
"HKCR\microsoft-edge-holographic"
"HKCR\microsoftmusic"
"HKCR\microsoftvideo"
"HKCR\ms-clipchamp"
"HKCR\ms-cortana"
"HKCR\ms-gamingoverlay"
"HKCR\ms-insights"
"HKCR\ms-meetnowflyout"
"HKCR\ms-teams"
"HKCR\ms-xbet-survey"
"HKCR\msnews"
"HKCR\msnweather"
"HKCR\msxbox"
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
"HKCU\Software\Classes\feedback-hub"
"HKCU\Software\Classes\grvopen"
"HKCU\Software\Classes\insiderhub"
"HKCU\Software\Classes\ms-cortana2"
"HKCU\Software\Classes\ms-gamebar"
"HKCU\Software\Classes\ms-gamebarservices"
"HKCU\Software\Classes\msgamepass"
"HKCU\Software\Classes\msgamingapp"
"HKCU\Software\Classes\windows-feedback"
"HKCU\Software\Classes\zune"
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
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\bingmaps"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\bingnews"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\bingweather"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\feedback-hub"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\insiderhub"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-gamebar"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-gamebarservices"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-gamingoverlay"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-teams"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\msgamepass"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\msgamingapp"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\msnweather"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\mswindowsmusic"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\windows-feedback"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-captures"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-friendfinder"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-gamehub"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-lfg"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-network"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-profile"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-settings"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-store"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xbox-tcui"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xboxgames"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\xboxidp"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\zune"
"HKLM\Software\Classes\MSEdgeHTM"
"HKLM\Software\Classes\MSEdgeMHT"
"HKLM\Software\Classes\MSEdgePDF"
"HKLM\Software\Classes\NetworkExplorerPlugins\Microsoft Corporation/Xbox 360"
"HKLM\Software\Clients\StartMenuInternet\Microsoft Edge"
"HKLM\Software\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}"
"HKLM\Software\Microsoft\Edge"
"HKLM\Software\Microsoft\KGL"
"HKLM\Software\Microsoft\MSN Apps\MSN Toolbar Suite"
"HKLM\Software\Microsoft\MicrosoftEdge"
"HKLM\Software\Microsoft\OneDrive"
"HKLM\Software\Microsoft\PolicyManager\default\TaskScheduler\EnableXboxGameSaveTask"
"HKLM\Software\Microsoft\TelemetryClient"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive1"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive2"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive3"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive4"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive5"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive6"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\ OneDrive7"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Ext\PreApproved\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\OneDriveSetup.exe"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge WebView2 Runtime"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{1F2B6AF3-C260-8666-5950-E3FEDBC851D6}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{39AF0813-FA7B-4860-ADBE-93B9B214B914}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{731F6BAA-A986-45A4-8936-7C3AAAAA760B}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{DF8C4194-1791-41CC-A455-8EBCCF084366}"
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
"HKU\Software\Microsoft\Windows\CurrentVersion\Cortana"
"HKU\Software\Microsoft\Windows\CurrentVersion\WindowsCopilot"
"HKU\Software\Microsoft\Xbox"
) DO (
       REG DELETE %%g /F >NUL 2>&1
      )
)

REM https://www.bleepingcomputer.com/forums/t/802105/3138awezipawezip-14360-x64-ffd303wmbhcj/
:: Solo Registry Value
REG DELETE "HKCR\.htm\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.html\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.mht\OpenWithProgids" /V MSEdgeMHT /F >NUL 2>&1
REG DELETE "HKCR\.pdf\OpenWithProgids" /V MSEdgePDF /F >NUL 2>&1
REG DELETE "HKCR\.shtml\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCU\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V OneDriveSetup /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V TeamsMachineInstaller /F >NUL 2>&1
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
IF NOT EXIST %WINDIR%\grep.exe GOTO :PackagesHeur
REG QUERY "HKCR" 2>NUL|GREP -Eis "^HKEY_CLASSES_ROOT\\(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">"%TEMP%\privwindozelogh.txt"
REG QUERY "HKCR\ActivatableClasses\Package" 2>NUL|GREP -Eis "^HKEY_CLASSES_ROOT\\ActivatableClasses\\Package\\Microsoft\.(WindowsFeedbackHub|Xbox|YourPhone|Zune)">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKCR\Extensions\ContractId\Windows.AppService\PackageId" 2>NUL|GREP -Eis "^HKEY_CLASSES_ROOT\\Extensions\\ContractId\\Windows\.AppService\\PackageId\\Microsoft\.(WindowsFeedbackHub|Xbox|YourPhone|Zune)">>"%TEMP%\privwindozelogh.txt"
for /f %%g in (%TEMP%\privwindozelogh.txt) DO (
    REG DELETE "%%g" /F >NUL 2>&1
)
:: Heuristic Registry Value
:HeurValue
IF NOT EXIST %WINDIR%\sed.exe GOTO :Policies
IF NOT EXIST %WINDIR%\grep.exe GOTO :Policies
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>NUL|GREP -Eis "MicrosoftEdgeAutoLaunch_">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//g" <"%TEMP%\privwindozelog.txt" >"%TEMP%\privwindozelog2.txt"
for /f %%g in (%TEMP%\privwindozelog2.txt) DO (
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%g" /F >NUL 2>&1
)

REM HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall
:: Policies
:Policies
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /T REG_DWORD /V ScoobeSystemSettingEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1
REG ADD "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /T REG_DWORD /V TurnOffWindowsCopilot /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\System\AllowTelemetry" /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\WindowsAI\TurnOffWindowsCopilot" /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V AllowTelemetry /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V MaxTelemetryAllowed /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /T REG_DWORD /V DontSendAdditionalData /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1
REG ADD "HKU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /T REG_DWORD /V Enabled /D 0 /F >NUL 2>&1
REG ADD "HKU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /T REG_DWORD /V ShowedToastAtLevel /D 1 /F >NUL 2>&1
REG ADD "HKU\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1
REG ADD "HKU\Software\Policies\Microsoft\Windows\WindowsCopilot" /T REG_DWORD /V TurnOffWindowsCopilot /D 1 /F >NUL 2>&1

:: Tasks
:Tasks
Echo([^|^|^|^|  ] Scanning Tasks
REM Tasks creating new variants of themselves upon deletion? Little hard to prove at this point but will monitor (haha)
REM Yes, new tasks are formed, but I think this is due to the service being disabled as well. Upon disabling InstallService SVC, WakeUpAndContinueUpdates, and WakeUpAndScanForUpdates are created (but disabled)
IF NOT EXIST %SYS32%\schtasks.exe GOTO :Services
for %%g in (
"Microsoft\Office\OfficeTelemetryAgentFallBack"
"Microsoft\Office\OfficeTelemetryAgentLogOn"
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
"Microsoft\Windows\Servicing\OOBEFodSetup"
"Microsoft\Windows\Shell\CreateObjectTask"
"Microsoft\Windows\Shell\FamilySafetyMonitor"
"Microsoft\Windows\Shell\FamilySafetyRefreshTask"
"Microsoft\Windows\Shell\IndexerAutomaticMaintenance"
"Microsoft\Windows\Shell\ThemesSyncedImageDownload"
"Microsoft\Windows\Sustainability\SustainabilityTelemetry"
"Microsoft\Windows\User Profile Service\HiveUploadTask"
"Microsoft\Windows\WOF\WIM-Hash-Management"
"Microsoft\Windows\WOF\WIM-Hash-Validation"
"Microsoft\Windows\WlanSvc\CDSSync"
"Microsoft\Windows\WwanSvc\NotificationTask"
"Microsoft\Windows\WwanSvc\OobeDiscovery"
"Microsoft\Windows\capabilityaccessmanager\maintenancetasks"
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
IF ERRORLEVEL 1 ( GOTO :Optimize )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Microsoft\Windows\Windows Defender\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:Optimize
dir /b "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^Optimize Push Notification Data File">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Services )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:: Services
:Services
Echo([^|^|^|^|^| ] Scanning Services
IF NOT EXIST %SYS32%\sc.exe GOTO :ServicesHuer
sc config DiagTrack start= disabled>NUL
sc config DoSvc start= disabled>NUL
sc config InstallService start= disabled>NUL
sc config "OneDrive Updater Service" start= disabled>NUL
sc config WpnService start= disabled>NUL
sc config XblAuthManager start= disabled>NUL
sc config XblGameSave start= disabled>NUL
sc config XboxGipSvc start= disabled>NUL
sc config XboxNetApiSvc start= disabled>NUL
sc config dmwappushservice start= disabled>NUL
sc config edgeupdate start= disabled>NUL
sc config edgeupdatem start= disabled>NUL
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
sc stop DiagTrack>NUL
sc stop DoSvc>NUL
sc stop InstallService>NUL
sc stop "OneDrive Updater Service">NUL
sc stop WpnService>NUL
sc stop XblAuthManager>NUL
sc stop XblGameSave>NUL
sc stop XboxGipSvc>NUL
sc stop XboxNetApiSvc>NUL
sc stop dmwappushservice>NUL
sc stop edgeupdate>NUL
sc stop edgeupdatem>NUL
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
sc delete edgeupdate>NUL
sc delete edgeupdatem>NUL
sc delete MicrosoftEdgeElevationService>NUL
sc delete "OneDrive Updater Service">NUL

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
Echo([^|^|^|^|^|^|] Scanning File System
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
IF ERRORLEVEL 1 ( GOTO :locallow64hex )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "discord=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Cache\Cache_Data\!discord!" >NUL 2>&1
    ENDLOCAL
)
:: locallow64hex
:locallow64hex
DIR /B/A:-D "%LOCALLOW%" 2>NUL|GREP -Es "^[a-f0-9]{64}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Files )
for /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    set "locallow64hex=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!LOCALLOW!\!locallow64hex!" >NUL 2>&1
    ENDLOCAL
)
REM https://www.bleepingcomputer.com/forums/t/803153/windows-defender-freezing-not-completing/?hl=%2Bonedrive1
:: Files
:Files
for %%g in (
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS17%\OneDrive.lnk"
"%PROGRAMS27%\Microsoft Corporation\Microsoft Teams.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PROGRAMS27%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%TEMP%\privwindozelog*.txt"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Desktop\Microsoft Teams.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%WINDIR%\grep.exe"
"%WINDIR%\libiconv2.dll"
"%WINDIR%\libintl3.dll"
"%WINDIR%\nircmd.exe"
"%WINDIR%\pcre3.dll"
"%WINDIR%\regex2.dll"
"%WINDIR%\sed.exe"
"%WINDIR%\sort_.exe"
) DO (
       DEL /F/Q %%g >NUL 2>&1
      )
)
:: Folders
:Folders
for %%g in (
"%ALLUSERSPROFILE%\Intel Telemetry"
"%ALLUSERSPROFILE%\Microsoft OneDrive"
"%ALLUSERSPROFILE%\Microsoft\DiagnosticLogCSP"
"%ALLUSERSPROFILE%\Microsoft\EdgeUpdate"
"%APPDATA%\Microsoft\Teams"
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\Teams"
"%LOCALA%\Microsoft\TeamsMeetingAddin"
"%LOCALA%\Microsoft\XboxLive"
"%LOCALA%\OneDrive"
"%PROGRAMFILES%\Microsoft OneDrive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES(x86)%\Microsoft\Edge"
"%PROGRAMFILES(x86)%\Microsoft\EdgeCore"
"%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate"
"%PROGRAMFILES(x86)%\Microsoft\EdgeWebView"
"%PROGRAMFILES(x86)%\Teams Installer"
"%SYS32%\Microsoft-Edge-WebView"
"%USERPROFILE%\MicrosoftEdgeBackups"
"%WINDIR%\GameBarPresenceWriter"
) DO (
      RD /S/Q %%g >NUL 2>&1
      )
)

:eof
Echo.
Echo.
Echo(Script completed! Exiting in 3 seconds...
timeout /t 03>NUL