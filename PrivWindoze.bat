:: PrivWindoze
:: Created by Furtivex
@echo OFF && color 17
title PrivWindoze by Furtivex - Version 2.1.0
ECHO(PrivWindoze by Furtivex - Version 2.1.0
ECHO.
ECHO.
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
CD /d %~dp0
FOR %%g in (
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
SET "QUICKLAUNCHALL=%APPDATA%\Microsoft\Internet Explorer\Quick Launch"
SET "PROGRAMS1ALL=%ALLUSERSPROFILE%\Start Menu\Programs"
SET "PROGRAMS2ALL=%USERPROFILE%\Start Menu\Programs"
IF EXIST "%WINDIR%\Sysnative\cmd.exe" ( SET "SYS32=%WINDIR%\Sysnative" ) else ( SET "SYS32=%WINDIR%\System32" )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF EXIST %WINDIR%\syswow64 ( set ARCH=x64 ) else ( set ARCH=x86 )
IF %ARCH%==x64 (
 SET "SYSWOW64=%WINDIR%\SysWOW64"
)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "LOCALA=%LOCALAPPDATA%"
SET "LOCALLOW=%USERPROFILE%\Appdata\LocalLow"
SET "PROGRAMS17=%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs"
SET "PROGRAMS27=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
SET "PUBDESKTOP=%SYSTEMDRIVE%\Users\Public\Desktop"
SET "QUICKLAUNCH17=%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
SET "QUICKLAUNCH27=%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
SET "STARTMENU17=%ALLUSERSPROFILE%\Microsoft\windows\Start Menu"
SET "STARTMENU27=%APPDATA%\Microsoft\Windows\Start Menu"
SET "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
:: Processes
:Processes
Echo([^|     ] Scanning Processes
IF NOT EXIST %SYS32%\taskkill.exe GOTO :WindowsApps
FOR %%g in (
"dcv2.exe"
"elevation_service.exe"
"filecoauth.exe"
"filesynchelper.exe"
"gamebar_widget.exe"
"microsoft.media.player.exe"
"microsoft.sharepoint.exe"
"microsoftedgeupdate.exe"
"ms-teams.exe"
"msedge.exe"
"msedgewebview2.exe"
"onedrive.exe"
"onedriveupdaterservice.exe"
"teams.exe"
"update.exe"
"widgets.exe"
"xboxpcapp.exe"
"xboxpcappft.exe"
) DO (
       TASKKILL /F /IM %%g >NUL 2>&1
      )
)
:: Windows Apps
:WindowsApps
Echo([^|^|    ] Scanning Windows Apps
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe GOTO :Registry
IF NOT EXIST %WINDIR%\grep.exe GOTO :Registry
IF NOT EXIST %WINDIR%\sed.exe GOTO :Registry
IF NOT EXIST %WINDIR%\sort_.exe GOTO :Registry
POWERSHELL -command "Get-AppxPackage -AllUsers | Format-List -Property PackageFullName">"%TEMP%\privwindozeloga.txt"
GREP -Eis " : (Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)| : (acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|WildTangentGames))" <"%TEMP%\privwindozeloga.txt" >"%TEMP%\privwindozeloga2.txt"
SED -r "s/^PackageFullName : //" <"%TEMP%\privwindozeloga2.txt" >"%TEMP%\privwindozeloga3.txt"
SORT_ -f -u <"%TEMP%\privwindozeloga3.txt" >"%TEMP%\privwindozeloga4.txt"
FOR /f %%g in (%TEMP%\privwindozeloga4.txt) DO (
    POWERSHELL -command "Remove-AppxPackage -AllUsers -Package %%g" >NUL 2>&1
)
REM B9ECED6F = Asus bundles
REM AD2F1837 = HP Bundles
REM 549981C3F5F10 = MS Cortana
REM 9426MICRO = MSI // Micro Star International Bundles
:: Registry
:Registry
Echo([^|^|^|   ] Scanning Registry
IF %ARCH%==x64 (
                 FOR %%g in (
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

FOR %%g in (
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
"HKCR\ms-clipchamp"
"HKCR\ms-cortana"
"HKCR\ms-gamingoverlay"
"HKCR\ms-insights"
"HKCR\ms-meetnow"
"HKCR\ms-meetnowflyout"
"HKCR\ms-mobileplans"
"HKCR\ms-teams"
"HKCR\ms-xbet-survey"
"HKCR\msnews"
"HKCR\msnnews"
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
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-insights"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-meetnowflyout"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-teams"
"HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\ms-xbet-survey"
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
REG DELETE "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /VA /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "com.squirrel.Teams.Teams" /F >NUL 2>&1
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

:: Heuristic Registry Key
REG QUERY "HKCR" 2>NUL|GREP -Eis "^HKEY_CLASSES_ROOT\\(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">"%TEMP%\privwindozelogh.txt"
REG QUERY "HKCR\ActivatableClasses\Package" 2>NUL|GREP -Eis "\\Package\\Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)|\\Package\\(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|WildTangentGames)">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKCR\Extensions\ContractId\Windows.AppService\PackageId" 2>NUL|GREP -Eis "\\PackageId\\Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)|\\PackageId\\(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|WildTangentGames)">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol" 2>NUL|GREP -Eis "(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Microsoft\Tracing" 2>NUL>>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages" 2>NUL|GREP -Eis "\\Packages\\Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)|\\Packages\\(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|WildTangentGames)">>"%TEMP%\privwindozelogh.txt"
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelogh.txt") DO (
   REG DELETE "%%g" /F >NUL 2>&1
)
REM HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall
:: Heuristic Registry Value
:HeurValue
IF NOT EXIST %WINDIR%\sed.exe GOTO :Policies
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>NUL|GREP -Eis "MicrosoftEdgeAutoLaunch_[A-F0-9]{32}">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//g" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /f %%g in (%TEMP%\privwindozelogr2.txt) DO (
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%g" /F >NUL 2>&1
)
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
FOR %%g in (
"Lenovo\Vantage\Schedule\DailyTelemetryTransmission"
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
DIR /b "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^MicrosoftEdgeUpdateTask">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :OneDriveTask )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:OneDriveTask
DIR /b "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^OneDrive">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :TelemetryTask )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:TelemetryTask
DIR /b "%SYS32%\Tasks" 2>NUL|FINDSTR -i "Telemetry">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :NvidiaTask )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:NvidiaTask
DIR /b "%SYS32%\Tasks" 2>NUL|FINDSTR -i "NvTmRep_">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :WindowsDefenderTask )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:WindowsDefenderTask
DIR /b "%SYS32%\Tasks\Microsoft\Windows\Windows Defender" 2>NUL|FINDSTR -ri "^Windows Defender">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Optimize )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Microsoft\Windows\Windows Defender\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:Optimize
DIR /b "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^Optimize Push Notification Data File">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Services )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
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
SC CONFIG DiagTrack start= disabled>NUL
SC CONFIG DoSvc start= disabled>NUL
SC CONFIG InstallService start= disabled>NUL
SC CONFIG "OneDrive Updater Service" start= disabled>NUL
SC CONFIG WpnService start= disabled>NUL
SC CONFIG XblAuthManager start= disabled>NUL
SC CONFIG XblGameSave start= disabled>NUL
SC CONFIG XboxGipSvc start= disabled>NUL
SC CONFIG XboxNetApiSvc start= disabled>NUL
SC CONFIG dmwappushservice start= disabled>NUL
SC CONFIG edgeupdate start= disabled>NUL
SC CONFIG edgeupdatem start= disabled>NUL
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SC STOP DiagTrack>NUL
SC STOP DoSvc>NUL
SC STOP InstallService>NUL
SC STOP "OneDrive Updater Service">NUL
SC STOP WpnService>NUL
SC STOP XblAuthManager>NUL
SC STOP XblGameSave>NUL
SC STOP XboxGipSvc>NUL
SC STOP XboxNetApiSvc>NUL
SC STOP dmwappushservice>NUL
SC STOP edgeupdate>NUL
SC STOP edgeupdatem>NUL
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SC DELETE edgeupdate>NUL
SC DELETE edgeupdatem>NUL
SC DELETE MicrosoftEdgeElevationService>NUL
SC DELETE "OneDrive Updater Service">NUL

:ServicesHuer
IF NOT EXIST %SYS32%\reg.exe GOTO :DiscordFiles
IF NOT EXIST %WINDIR%\grep.exe GOTO :DiscordFiles
REM S2 edgeupdate1db0cab9f75c19; "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" /svc [X]
REM S3 edgeupdatem1db0cab9f91f3b; "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" /medsvc [X]
REG QUERY "HKLM\SYSTEM\CurrentControlSet\services" 2>NUL|GREP -Eis "\\edgeupdatem?[a-f0-9]{12,}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :DiscordFiles )
FOR /f %%g in (%TEMP%\privwindozelog.txt) DO (
    REG DELETE "%%g" /F >NUL 2>&1
)
:: Discord Files
:DiscordFiles
Echo([^|^|^|^|^|^|] Scanning File System
DIR /b "%APPDATA%\discord\Code Cache\js" 2>NUL|FINDSTR -ri "^[a-f0-9].*_0$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Discord2 )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "discord=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Code Cache\js\!discord!" >NUL 2>&1
    ENDLOCAL
)
:Discord2
DIR /b "%APPDATA%\discord\Cache\Cache_Data" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :locallow64hex )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "discord=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Cache\Cache_Data\!discord!" >NUL 2>&1
    ENDLOCAL
)
:: locallow64hex
:locallow64hex
DIR /B/A:-D "%LOCALLOW%" 2>NUL|GREP -Es "^[a-f0-9]{64}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :InboxApps )
FOR /f "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "locallow64hex=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!LOCALLOW!\!locallow64hex!" >NUL 2>&1
    ENDLOCAL
)
:InboxApps
DIR /B/A:-D "%WINDIR%\InboxApps" 2>NUL|GREP -Eis "^Microsoft\.(Bing|Copilot|StartExperiencesApp)">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :D3DSCache )
FOR /f %%g in (%TEMP%\privwindozelog.txt) DO (
    DEL /F/Q "%WINDIR%\InboxApps\%%g" >NUL 2>&1
)
:D3DSCache
DIR /B/A:D "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Files )
FOR /f %%g in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache\%%g" >NUL 2>&1
)
:: Files
:Files
FOR %%g in (
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS17%\OneDrive.lnk"
"%PROGRAMS27%\Microsoft Corporation\Microsoft Teams.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PROGRAMS27%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Desktop\Microsoft Teams.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%TEMP%\privwindozelog*"
"%TEMP%\README.md"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\AMD\DxCache\*.*"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.*"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Temp\*.*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*.*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCache\*.*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Temp\*.*"
"%WINDIR%\SystemTemp\*.*"
"%WINDIR%\Temp\*.*"
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
FOR %%g in (
"%ALLUSERSPROFILE%\Intel Telemetry"
"%ALLUSERSPROFILE%\Microsoft OneDrive"
"%ALLUSERSPROFILE%\Microsoft\DiagnosticLogCSP"
"%ALLUSERSPROFILE%\Microsoft\EdgeUpdate"
"%APPDATA%\Microsoft\Teams"
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\Teams"
"%LOCALA%\Microsoft\TeamsMeetingAdd-in"
"%LOCALA%\Microsoft\TeamsMeetingAddin"
"%LOCALA%\Microsoft\XboxLive"
"%LOCALA%\OneDrive"
"%PROGRAMFILES%\Microsoft OneDrive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES(x86)%\Microsoft\Edge"
"%PROGRAMFILES(x86)%\Microsoft\EdgeCore"
"%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate"
"%PROGRAMFILES(x86)%\Microsoft\EdgeWebView"
"%PROGRAMFILES(x86)%\Microsoft\Temp"
"%PROGRAMFILES(x86)%\Teams Installer"
"%SYS32%\Microsoft-Edge-WebView"
"%TEMP%\dependencies"
"%USERPROFILE%\MicrosoftEdgeBackups"
"%WINDIR%\GameBarPresenceWriter"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\GameDVR"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\GameExplorer"
"%WINDIR%\ServiceProfiles\LocalService\OneDrive"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\GameDVR"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\GameExplorer"
"%WINDIR%\ServiceProfiles\NetworkService\OneDrive"
) DO (
      RD /S/Q %%g >NUL 2>&1
      )
)
IF %ARCH%==x64 ( MD "%PROGRAMFILES(x86)%\Microsoft\Temp" )
:eof
ECHO.
ECHO.
ECHO(Scan complete! Enjoy a more private Windows!
TIMEOUT /t 03>NUL