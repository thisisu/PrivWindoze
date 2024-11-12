:: PrivWindoze
:: Created by Furtivex
@echo OFF && color 17
title PrivWindoze by Furtivex - Version 2.2.2
ECHO(PrivWindoze by Furtivex - Version 2.2.2
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
) DO ( COPY /Y "%CD%\dependencies\%%g" "%WINDIR%" >NUL 2>&1 )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "QUICKLAUNCHALL=%APPDATA%\Microsoft\Internet Explorer\Quick Launch"
SET "PROGRAMS1ALL=%ALLUSERSPROFILE%\Start Menu\Programs"
SET "PROGRAMS2ALL=%USERPROFILE%\Start Menu\Programs"
IF EXIST "%WINDIR%\Sysnative\cmd.exe" ( SET "SYS32=%WINDIR%\Sysnative" ) else ( SET "SYS32=%WINDIR%\System32" )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF EXIST %WINDIR%\syswow64 ( SET ARCH=x64 ) else ( SET ARCH=x86 )
IF %ARCH%==x64 ( SET "SYSWOW64=%WINDIR%\SysWOW64" )
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
SET longexit=false
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
:Processes
Echo([^|     ] Scanning Processes
IF NOT EXIST %SYS32%\taskkill.exe GOTO :WindowsApps
FOR %%g in (
"apphelpercap.exe"
"appmonitorplugin.exe"
"bingpopup.exe"
"camusage.exe"
"dcv2.exe"
"diagscap.exe"
"elevation_service.exe"
"filecoauth.exe"
"filesynchelper.exe"
"gamebar_widget.exe"
"hpcommrecovery.exe"
"installedpackagesagent.exe"
"intelanalyticsservice.exe"
"lenovonow.task.exe"
"lrio.exe"
"microsoft.media.player.exe"
"microsoft.sharepoint.exe"
"microsoftedgeupdate.exe"
"micusage.exe"
"ms-teams.exe"
"msedge.exe"
"msedgewebview2.exe"
"networkcap.exe"
"onedrive.exe"
"onedriveupdaterservice.exe"
"operfmon.exe"
"sc.exe"
"scheduleeventaction.exe"
"sysinfocap.exe"
"teams.exe"
"tobii.service.exe"
"touchpointanalyticsclientservice.exe"
"ubtservice.exe"
"udclientservice.exe"
"uninstall.exe"
"update.exe"
"widgets.exe"
"xboxpcapp.exe"
"xboxpcappft.exe"
) DO (
       TASKKILL /F /IM %%g >NUL 2>&1
      )
)
:WindowsApps
Echo([^|^|    ] Scanning Windows Apps
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe GOTO :Registry
IF NOT EXIST %WINDIR%\grep.exe GOTO :Registry
IF NOT EXIST %WINDIR%\sed.exe GOTO :Registry
IF NOT EXIST %WINDIR%\sort_.exe GOTO :Registry
POWERSHELL -command "Get-AppxPackage -AllUsers | Format-List -Property PackageFullName">"%TEMP%\privwindozeloga.txt"
GREP -Eis " : (Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)| : (acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames))" <"%TEMP%\privwindozeloga.txt" >"%TEMP%\privwindozeloga2.txt"
SED -r "s/^PackageFullName : //" <"%TEMP%\privwindozeloga2.txt" >"%TEMP%\privwindozeloga3.txt"
SORT_ -f -u <"%TEMP%\privwindozeloga3.txt" >"%TEMP%\privwindozeloga4.txt"
FOR /F %%g in (%TEMP%\privwindozeloga4.txt) DO (
    POWERSHELL -command "Remove-AppxPackage -AllUsers -Package %%g" >NUL 2>&1
)
REM 549981C3F5F10 = MS Cortana
REM 9426MICRO = MSI // Micro Star International Bundles
REM AD2F1837 = HP Bundles
REM B9ECED6F = Asus bundles
REM E046963F = Lenovo Bundles

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

REG DELETE "HKCR\.htm\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.html\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.mht\OpenWithProgids" /V MSEdgeMHT /F >NUL 2>&1
REG DELETE "HKCR\.pdf\OpenWithProgids" /V MSEdgePDF /F >NUL 2>&1
REG DELETE "HKCR\.shtml\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCU\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V OneDriveSetup /F >NUL 2>&1
REG DELETE "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /VA /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "com.squirrel.Teams.Teams" /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V LenovoVantageToolbar /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V HPOneAgentService /F >NUL 2>&1
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
REG DELETE "HKU\Software\Microsoft\Windows\CurrentVersion\Run" /V "com.slatedigital.analytics" /F >NUL 2>&1
REG DELETE "HKU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDrive" /F >NUL 2>&1

REG QUERY "HKCR" 2>NUL|GREP -Eis "^HKEY_CLASSES_ROOT\\(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">"%TEMP%\privwindozelogh.txt"
REG QUERY "HKCR\ActivatableClasses\Package" 2>NUL|GREP -Eis "\\Package\\Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)|\\Package\\(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKCR\Extensions\ContractId\Windows.AppService\PackageId" 2>NUL|GREP -Eis "\\PackageId\\Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)|\\PackageId\\(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol" 2>NUL|GREP -Eis "(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Microsoft\Tracing" 2>NUL>>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages" 2>NUL|GREP -Eis "\\Packages\\Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)|\\Packages\\(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)">>"%TEMP%\privwindozelogh.txt"
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelogh.txt") DO (
   REG DELETE "%%g" /F >NUL 2>&1
)
REM s/\x22//g
IF NOT EXIST %WINDIR%\sed.exe GOTO :Policies
REG QUERY "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"|GREP -Es "    \{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :FirewallOrphans )
GREP -Es "Name=Microsoft Edge|Name=@\{Microsoft\.(Bing|Todos|Xbox|Zune)|Name=@\{Clipchamp\." <"%TEMP%\privwindozelog.txt" >"%TEMP%\privwindozelogMS.txt"
IF ERRORLEVEL 1 ( GOTO :FirewallOrphans )
SED -r "s/^\s+(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}).*/\1/" <"%TEMP%\privwindozelogMS.txt" >"%TEMP%\privwindozeMS2.txt"
FOR /F %%g in (%TEMP%\privwindozeMS2.txt) DO (
    REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /V "%%g" /F >NUL 2>&1
)
:FirewallOrphans
GREP -Es "\|App=[A-Za-z]:.*\.exe" <"%TEMP%\privwindozelog.txt" >"%TEMP%\privwindozelog2.txt"
IF ERRORLEVEL 1 ( GOTO :Autolaunch )
SED -r "s/^\s+(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\})\s+REG_SZ\s+v.*\|App=([A-Za-z]:.*\.exe).*\|$/\1     \2/" <"%TEMP%\privwindozelog2.txt" >"%TEMP%\privwindozelog3.txt"
SED -r "s/^(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}).*/\1/" <"%TEMP%\privwindozelog3.txt" >"%TEMP%\privwindozelog3clsids.txt"
SED -r "s/^.*\s{5}([A-Za-z]:.*\.exe)$/\1/" <"%TEMP%\privwindozelog3.txt" >"%TEMP%\privwindozelog3paths.txt"
FOR /F %%g in (%TEMP%\privwindozelog3clsids.txt) DO (
    FOR /F "usebackq delims=" %%i in ("%TEMP%\privwindozelog3paths.txt") DO (
    SET "firewallpath=%%i"
    SETLOCAL EnableDelayedExpansion
    IF NOT EXIST "!firewallpath!" REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /V %%g /F >NUL 2>&1
    ENDLOCAL
    )
)
:Autolaunch
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>NUL|GREP -Eis "MicrosoftEdgeAutoLaunch_[A-F0-9]{32}">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//g" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /F %%g in (%TEMP%\privwindozelogr2.txt) DO (
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%g" /F >NUL 2>&1
)
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


:Tasks
Echo([^|^|^|^|  ] Scanning Tasks
IF NOT EXIST %SYS32%\schtasks.exe GOTO :Services
FOR %%g in (
"HPOneAgentRepairTask"
"HP\Consent Manager Launcher"
"Intel\Intel Telemetry 3"
"Hewlett-Packard\HP Support Assistant\HP Support Assistant Update Notice"
"Lenovo\ImController\Lenovo iM Controller Monitor"
"Lenovo\ImController\Lenovo iM Controller Scheduled Maintenance"
"Lenovo\LenovoNowQuarterlyLaunch"
"Lenovo\LenovoNowTask"
"Lenovo\UDC\Lenovo UDC Diagnostic Scan"
"Lenovo\UDC\Lenovo UDC Monitor"
"Lenovo\Vantage\Lenovo.Vantage.ServiceMaintainance"
"Lenovo\Vantage\Schedule\BatteryGaugeAddinDailyScheduleTask"
"Lenovo\Vantage\Schedule\DailyTelemetryTransmission"
"Lenovo\Vantage\Schedule\GenericMessagingAddin"
"Lenovo\Vantage\Schedule\HeartbeatAddinDailyScheduleTask"
"Lenovo\Vantage\Schedule\IdeaNotebookAddinDailyEvent"
"Lenovo\Vantage\Schedule\Lenovo.Vantage.SmartPerformance.DelayedMonthlyReport"
"Lenovo\Vantage\Schedule\Lenovo.Vantage.SmartPerformance.MonthlyReport"
"Lenovo\Vantage\Schedule\Lenovo.Vantage.SmartPerformance.SScan"
"Lenovo\Vantage\Schedule\LenovoCompanionAppAddinDailyScheduleTask"
"Lenovo\Vantage\Schedule\LenovoSystemUpdateAddin_WeeklyTask"
"Lenovo\Vantage\Schedule\SettingsWidgetAddinDailyScheduleTask"
"Lenovo\Vantage\Schedule\SmartPerformance.ExpireReminder"
"Lenovo\Vantage\Schedule\VantageCoreAddinIdleScheduleTask"
"Lenovo\Vantage\Schedule\VantageCoreAddinWeekScheduleTask"
"Lenovo\Vantage\StartupFixPlan"
"McAfee\WPS\McAfee Anti-Tracker Scanner"
"McAfee\WPS\McAfee Anti-tracker notification"
"McAfee\WPS\McAfee Cloud Configuration Check"
"McAfee\WPS\McAfee Health Check"
"McAfee\WPS\McAfee Hotfix"
"McAfee\WPS\McAfee Message Check"
"McAfee\WPS\McAfee PC Optimizer Task"
"McAfee\WPS\McAfee Scheduled Tracker Remover"
"Microsoft\Office\Office Performance Monitor"
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
"Microsoft\Windows\Location\Notifications"
"Microsoft\Windows\Maintenance\WinSAT"
"Microsoft\Windows\Maps\MapsToastTask"
"Microsoft\Windows\Maps\MapsUpdateTask"
"Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
"Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
"Microsoft\Windows\PLA\New Data Collector Set"
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
"Microsoft\Windows\UpdateOrchestrator\USO_UxBroker"
"Microsoft\Windows\User Profile Service\HiveUploadTask"
"Microsoft\Windows\WOF\WIM-Hash-Management"
"Microsoft\Windows\WOF\WIM-Hash-Validation"
"Microsoft\Windows\WlanSvc\CDSSync"
"Microsoft\Windows\WwanSvc\NotificationTask"
"Microsoft\Windows\WwanSvc\OobeDiscovery"
"Microsoft\Windows\capabilityaccessmanager\maintenancetasks"
"Microsoft\XblGameSave\XblGameSaveTask"
"Samsung_PSSD_Registration_Plus"
"TVT\TVSUUpdateTask"
"TVT\TVSUUpdateTask_UserLogOn"
"UEIPInvitation"
"UbtFrameworkService"
) DO (
       SCHTASKS /DELETE /TN %%g /F >NUL 2>&1
       DEL /F/Q "%SYS32%\Tasks\%%g" >NUL 2>&1
       DEL /F/Q "%SYS32%\Tasks_Migrated\%%g" >NUL 2>&1
      )
)
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^MicrosoftEdgeUpdateTask">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :OneDriveTask )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:OneDriveTask
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^OneDrive">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :TelemetryTask )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:TelemetryTask
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -i "Telemetry">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :NvidiaTask )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:NvidiaTask
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -i "NvTmRep_">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :WindowsDefenderTask )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:WindowsDefenderTask
DIR /B "%SYS32%\Tasks\Microsoft\Windows\Windows Defender" 2>NUL|FINDSTR -ri "^Windows Defender">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Optimize )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Microsoft\Windows\Windows Defender\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:Optimize
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^Optimize Push Notification Data File">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :TimeBasedEvents )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:TimeBasedEvents
DIR /B "%SYS32%\Tasks\Lenovo\ImController\TimeBasedEvents" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :UDCLen )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Lenovo\ImController\TimeBasedEvents\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Lenovo\ImController\TimeBasedEvents\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Lenovo\ImController\TimeBasedEvents\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:UDCLen
DIR /B "%SYS32%\Tasks\Lenovo\UDC\MessagingPlugin" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :UDCLen2 )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Lenovo\UDC\MessagingPlugin\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Lenovo\UDC\MessagingPlugin\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Lenovo\UDC\MessagingPlugin\!taskname!" >NUL 2>&1
    ENDLOCAL
)

:UDCLen2
DIR /B "%SYS32%\Tasks\Lenovo\UDC\SystemNotificationPlugin" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Services )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%g"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Lenovo\UDC\SystemNotificationPlugin\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Lenovo\UDC\SystemNotificationPlugin\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Lenovo\UDC\SystemNotificationPlugin\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:Services
Echo([^|^|^|^|^| ] Scanning Services
IF NOT EXIST %SYS32%\sc.exe GOTO :ServicesHuer
sc config "hp comm recover" start= disabled>nul
sc config "onedrive updater service" start= disabled>nul
sc config diagtrack start= disabled>nul
sc config dmwappushservice start= disabled>nul
sc config dosvc start= disabled>nul
sc config edgeupdate start= disabled>nul
sc config edgeupdatem start= disabled>nul
sc config filesynchelper start= disabled>nul
sc config hp-one-agent-service start= disabled>nul
sc config hpapphelpercap start= disabled>nul
sc config hpcustomcapdriver start= disabled>nul
sc config hpdiagscap start= disabled>nul
sc config hpnetworkcap start= disabled>nul
sc config hpsysinfocap start= disabled>nul
sc config hptouchpointanalyticsservice start= disabled>nul
sc config installservice start= disabled>nul
sc config tobiialenovoyx80 start= disabled>nul
sc config tobiirgb start= disabled>nul
sc config udcservice start= disabled>nul
sc config ueipsvc start= disabled>nul
sc config wpnservice start= disabled>nul
sc config xblauthmanager start= disabled>nul
sc config xblgamesave start= disabled>nul
sc config xboxgipsvc start= disabled>nul
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
sc stop "hp comm recover">nul
sc stop "onedrive updater service">nul
sc stop diagtrack>nul
sc stop dmwappushservice>nul
sc stop dosvc>nul
sc stop edgeupdate>nul
sc stop edgeupdatem>nul
sc stop filesynchelper>nul
sc stop hp-one-agent-service>nul
sc stop hpapphelpercap>nul
sc stop hpcustomcapdriver>nul
sc stop hpdiagscap>nul
sc stop hpnetworkcap>nul
sc stop hpsysinfocap>nul
sc stop hptouchpointanalyticsservice>nul
sc stop installservice>nul
sc stop tobiialenovoyx80>nul
sc stop tobiirgb>nul
sc stop udcservice>nul
sc stop ueipsvc>nul
sc stop wpnservice>nul
sc stop xblauthmanager>nul
sc stop xblgamesave>nul
sc stop xboxgipsvc>nul
sc stop xboxnetapisvc>nul
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
sc delete "hp comm recover">nul
sc delete "onedrive updater service">nul
sc delete edgeupdate>nul
sc delete edgeupdatem>nul
sc delete filesynchelper>nul
sc delete hp-one-agent-service>nul
sc delete hpapphelpercap>nul
sc delete hpcustomcapdriver>nul
sc delete hpdiagscap>nul
sc delete hpnetworkcap>nul
sc delete hpsysinfocap>nul
sc delete hptouchpointanalyticsservice>nul
sc delete microsoftedgeelevationservice>nul
sc delete tobiialenovoyx80>nul
sc delete tobiirgb>nul
sc delete udcservice>nul
sc delete ueipsvc>nul
REM ~~~~~~~~~~~~~~~~~~~~~~~~>

:ServicesHuer
IF NOT EXIST %SYS32%\reg.exe GOTO :DiscordFiles
IF NOT EXIST %WINDIR%\grep.exe GOTO :DiscordFiles
REG QUERY "HKLM\SYSTEM\CurrentControlSet\services" 2>NUL|GREP -Eis "\\edgeupdatem?[a-f0-9]{12,}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :DiscordFiles )
FOR /F %%g in (%TEMP%\privwindozelog.txt) DO (
    REG DELETE "%%g" /F >NUL 2>&1
)
:DiscordFiles
Echo([^|^|^|^|^|^|] Scanning File System
DIR /B "%APPDATA%\discord\Code Cache\js" 2>NUL|FINDSTR -ri "^[a-f0-9].*_0$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Discord2 )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "discord=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Code Cache\js\!discord!" >NUL 2>&1
    ENDLOCAL
)
:Discord2
DIR /B "%APPDATA%\discord\Cache\Cache_Data" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :locallow64hex )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "discord=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Cache\Cache_Data\!discord!" >NUL 2>&1
    ENDLOCAL
)
:locallow64hex
DIR /B/A:-D "%LOCALLOW%" 2>NUL|GREP -Es "^[a-f0-9]{64}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :InboxApps )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "locallow64hex=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!LOCALLOW!\!locallow64hex!" >NUL 2>&1
    ENDLOCAL
)
:InboxApps
DIR /B/A:-D "%WINDIR%\InboxApps" 2>NUL|GREP -Eis "^Microsoft\.(Bing|Copilot|StartExperiencesApp)">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :D3DSCache )
FOR /F %%g in (%TEMP%\privwindozelog.txt) DO (
    DEL /F/Q "%WINDIR%\InboxApps\%%g" >NUL 2>&1
)
:D3DSCache
DIR /B/A:D "%LOCALA%\D3DSCache" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :D3DSCache2 )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "cache=%%g"
    SETLOCAL EnableDelayedExpansion
    RD /S/Q "!LOCALA!\D3DSCache\!cache!" >NUL 2>&1
    ENDLOCAL
)
:D3DSCache2
DIR /B/A:D "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :D3DSCache3 )
FOR /F %%g in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache\%%g" >NUL 2>&1
)
:D3DSCache3
DIR /B/A:D "%SYS32%\config\systemprofile\AppData\Local\D3DSCache" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Twtmp )
FOR /F %%g in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%SYS32%\config\systemprofile\AppData\Local\D3DSCache\%%g" >NUL 2>&1
)
:Twtmp
DIR /B/A:D "%SYS32%\config\systemprofile\AppData\Local" 2>NUL|GREP -Es "^tw-[a-f0-9]{2,}-[a-f0-9]{2,}-[a-f0-9]{2,}\.tmp$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :ClearTemp )
FOR /F %%g in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%SYS32%\config\systemprofile\AppData\Local\%%g" >NUL 2>&1
)
:ClearTemp
DIR /B/A:-D "%TEMP%\*" 2>NUL|GREP -Ev "PrivWindoze\.bat$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Localpackages )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "deltemp=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!TEMP!\!deltemp!" >NUL 2>&1
    ENDLOCAL
)
:Localpackages
DIR /B/A:D "%LOCALA%\Packages" 2>NUL|GREP -Eis "^Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)|^(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MicrosoftWindows\.Client\.WebExperience|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Rootkits )
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "packages=%%g"
    SETLOCAL EnableDelayedExpansion
    RD /S/Q "!LOCALA!\Packages\!packages!" >NUL 2>&1
    ENDLOCAL
)
:Rootkits
IF NOT EXIST %SYS32%\pnputil.exe GOTO :Files
IF NOT EXIST %WINDIR%\sed.exe GOTO :Files
IF NOT EXIST %WINDIR%\grep.exe GOTO :Files
IF NOT EXIST %WINDIR%\nircmd.exe GOTO :Files
PNPUTIL -E 2>NUL|GREP -Eis "^Published name :            (hp(analytics|customcap)comp\.inf|lenovoyx[x|8]0\.inf)$>"%TEMP%\privwindozeROOT.txt"
IF ERRORLEVEL 1 ( GOTO :Files )
ECHO.
ECHO.
ECHO(======= Lenovo or Hewlett Packard telemetry driver files detected! =======
NIRCMD BEEP 1400 50
SED -r "s/^Published name :            //" <"%TEMP%\privwindozeROOT.txt" >"%TEMP%\privwindozeROOT2.txt"
FOR /F %%g in (%TEMP%\privwindozeROOT2.txt) DO (
    PNPUTIL -D %%g /uninstall /force >NUL 2>&1
)

REM lenovoyx80.inf
REM lenovoyxx0.inf
REM hpcustomcapcomp.inf
REM hpanalyticscomp.inf

REM HP ROOTKIT https://www.bleepingcomputer.com/forums/t/802684/d-evice-in-use-by-another-user-screen-flashing-only-able-to-get-cmd-running/
REM LENOVO ROOTKIT https://www.bleepingcomputer.com/forums/t/803174/time-constantly-gets-off-taskbar-malfunctions-mbr-says-my-atldll-is-bad/

:Files
FOR %%g in (
"%APPDATA%\Slate Digital Connect\SDACollector\sdaCollector.vbs"
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS17%\OneDrive.lnk"
"%PROGRAMS27%\Microsoft Corporation\Microsoft Teams.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PROGRAMS27%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%SYS32%\config\systemprofile\AppData\Local\AMD\DxcCache\*"
"%SYS32%\config\systemprofile\AppData\Local\AMD\DxCache\*"
"%SYS32%\drivers\Lenovo\udc\Service\UDClientService.exe"
"%TEMP%\privwindozelog*"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Desktop\Microsoft Teams.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\AMD\DxCache\*"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache\*"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Temp\*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCache\*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Temp\*"
"%WINDIR%\SystemTemp\*"
"%WINDIR%\Temp\*"
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
"%PROGRAMFILES%\Acer\User Experience Improvement Program Service"
"%PROGRAMFILES%\HPCommRecovery"
"%PROGRAMFILES%\HP\HP One Agent"
"%PROGRAMFILES%\Intel\Telemetry 3.0"
"%PROGRAMFILES%\Microsoft OneDrive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES%\Tobii\Tobii EyeX"
"%PROGRAMFILES(x86)%\Lenovo\LenovoNow"
"%PROGRAMFILES(x86)%\Lenovo\VantageService"
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

ECHO.
ECHO.
ECHO(Scan complete! Enjoy a more private Windows!
TIMEOUT /t 03>NUL

:eof