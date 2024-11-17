:: PrivWindoze
:: Created by Furtivex
@echo OFF && color 17
title PrivWindoze by Furtivex - Version 2.6.8
ECHO(PrivWindoze by Furtivex - Version 2.6.8
ECHO.
ECHO.
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
CD /d "%~dp0"
FOR %%g in (
grep.exe
libiconv2.dll
libintl3.dll
pcre3.dll
regex2.dll
sed.exe
sort_.exe
) DO ( COPY /Y "%CD%\dependencies\%%g" "%WINDIR%" >NUL 2>&1 )

FOR %%g in (
proc_kill.dat
svc_delete.dat
svc_stop_disable.dat
reglocs_pkgs.dat
) DO ( COPY /Y "%CD%\%%g" "%TEMP%" >NUL 2>&1 )
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

FOR /F "tokens=2*" %%A IN ('REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName 2^>NUL') DO SET COMPUTERNAME=%%B
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>NUL') DO SET OS=%%B
Set StartDate=%date%
set StartTime=%time%

whoami /user>"%TEMP%\privwindozelogwho.txt"
GREP -Es "S-1-5-21-[0-9]{10}-[0-9]{10}-[0-9]{10}-[0-9]{3,4}$" <"%TEMP%\privwindozelogwho.txt" >"%TEMP%\privwindozelogwho2.txt"
IF ERRORLEVEL 1 ( GOTO :AdminChk )
SED -r "s/^.*(S-1-5-21-[0-9]{10}-[0-9]{10}-[0-9]{10}-[0-9]{3,4})$/\1/" <"%TEMP%\privwindozelogwho2.txt" >"%TEMP%\privwindozelogwho3.txt"
FOR /F %%g in (%TEMP%\privwindozelogwho3.txt) DO ( SET SID=%%g )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>

:AdminChk
net session >NUL 2>&1
IF %ERRORLEVEL% EQU 0 ( SET USERSTATUS=Administrator) else (
 Echo(*** PrivWindoze runs best with administrator privileges ***
 echo.
 Echo(If you wish to run with administrator privileges, please close this window and run as an administrator.
 echo.
 Echo(If you wish to run without administrator privileges, please hit any key to continue.
 echo.
 SET USERSTATUS=Limited
 pause
)

FOR %%g in (
grep.exe
libiconv2.dll
libintl3.dll
pcre3.dll
regex2.dll
sed.exe
sort_.exe
) DO ( IF NOT EXIST %WINDIR%\%%g GOTO :eof )

FOR %%g in (
proc_kill.dat
svc_delete.dat
svc_stop_disable.dat
reglocs_pkgs.dat
) DO ( IF NOT EXIST "%TEMP%\%%g" GOTO :eof )

:: Create System Restore Point
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe ECHO Powershell.exe is missing! && GOTO :Processes
POWERSHELL -command "Checkpoint-Computer -Description 'PrivWindoze' -RestorePointType 'MODIFY_SETTINGS'"

:: PROCESSES ::
:Processes
Echo([^|     ] Scanning Processes
FOR /F %%g in (%TEMP%\proc_kill.dat) DO (
    TASKKILL /F /IM "%%g" >NUL 2>&1
)

:: PACKAGES ::
:Packages
Echo([^|^|    ] Scanning Packages
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe ECHO Powershell.exe is missing! && GOTO :Recall
POWERSHELL -command "Get-AppxPackage -AllUsers | Format-List -Property PackageFullName">"%TEMP%\privwindozeloga.txt"
SED -r "s/^PackageFullName : //" <"%TEMP%\privwindozeloga.txt" >"%TEMP%\privwindozeloga2.txt"
GREP -Eis "^Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <"%TEMP%\privwindozeloga2.txt" >"%TEMP%\privwindozeloga2_found.txt"
GREP -Eis "^MicrosoftWindows\.Client\.WebExperience|^MicrosoftCorporationII\.(QuickAssist|WinAppRuntime)|LenovoCompanion|CortanaUI" <"%TEMP%\privwindozeloga2.txt" >>"%TEMP%\privwindozeloga2_found.txt"
GREP -Eis "^(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)" <"%TEMP%\privwindozeloga2.txt" >>"%TEMP%\privwindozeloga2_found.txt"
GREP -Evs "^(Microsoft\.XboxGameCallableUI|Microsoft\.MicrosoftEdgeDevToolsClient)" <"%TEMP%\privwindozeloga2_found.txt" >"%TEMP%\privwindozeloga2_found2.txt"
SORT_ -f -u <"%TEMP%\privwindozeloga2_found2.txt" >"%TEMP%\privwindozeloga2_del.txt"
FOR /F %%g in (%TEMP%\privwindozeloga2_del.txt) DO (
    Echo(%%g ^(Package^)>>"%TEMP%\003"
    POWERSHELL -command "Remove-AppxPackage -AllUsers -Package %%g" >NUL 2>&1
)

:Recall
REM 24H2 Update
IF NOT EXIST %SYS32%\Dism.exe ECHO Dism.exe is missing! && GOTO :Registry
%SYS32%\Dism.exe /Online /Disable-Feature /Featurename:Recall>NUL
REM DISM /Online /Cleanup-Image /CheckHealth (other useful command)

:: REGISTRY ::
:Registry
Echo([^|^|^|   ] Scanning Registry
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
"HKCR\com.clipchamp.app"
"HKCR\com.microsoft.3dviewer"
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
"HKLM\Software\Microsoft\EdgeUpdate"
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
"HKLM\Software\Microsoft\Windows\CurrentVersion\MicrosoftEdge"
"HKLM\Software\Microsoft\Windows\CurrentVersion\OneDriveSetup.exe"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge WebView2 Runtime"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{1F2B6AF3-C260-8666-5950-E3FEDBC851D6}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{39AF0813-FA7B-4860-ADBE-93B9B214B914}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{731F6BAA-A986-45A4-8936-7C3AAAAA760B}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{DF8C4194-1791-41CC-A455-8EBCCF084366}"
"HKLM\Software\Microsoft\Windows\CurrentVersion\{A7AB73A3-CB10-4AA5-9D38-6AEFFBDE4C91}"
"HKLM\Software\Microsoft\Xbox"
"HKLM\Software\Policies\Microsoft\Edge"
"HKLM\Software\Policies\Microsoft\MicrosoftEdge"
"HKLM\Software\Policies\Microsoft\Windows\OneDrive"
"HKU\.DEFAULT\Software\Microsoft\Edge"
"HKU\.DEFAULT\Software\Microsoft\OneDrive"
"HKU\.DEFAULT\Software\Microsoft\TelemetryClient"
"HKU\.DEFAULT\Software\Microsoft\Windows Script\Settings\Telemetry"
"HKU\.DEFAULT\Software\Microsoft\Xbox"
"HKU\S-1-5-19\Software\Microsoft\OneDrive"
"HKU\S-1-5-20\Software\Microsoft\OneDrive"
"HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
) DO (
       REG DELETE %%g /F >NUL 2>&1
)

REG DELETE "HKCR\.htm\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.html\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.mht\OpenWithProgids" /V MSEdgeMHT /F >NUL 2>&1
REG DELETE "HKCR\.pdf\OpenWithProgids" /V MSEdgePDF /F >NUL 2>&1
REG DELETE "HKCR\.shtml\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCU\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V OneDriveSetup /F >NUL 2>&1
REG DELETE "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /VA /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "Microsoft.Lists" /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "com.slatedigital.analytics" /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "com.squirrel.Teams.Teams" /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V LenovoVantageToolbar /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION" /V "OneDrive.exe" /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V HPOneAgentService /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V TeamsMachineInstaller /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V XboxStat /F >NUL 2>&1
REG DELETE "HKLM\Software\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDriveSetup" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V "OneDriveSetup" /F >NUL 2>&1


REG QUERY "HKCR" 2>NUL|GREP -Eis "^HKEY_CLASSES_ROOT\\(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol" 2>NUL|GREP -Eis "(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">>"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Microsoft\Tracing" 2>NUL>>"%TEMP%\privwindozelogh.txt"
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelogh.txt") DO (
   REG DELETE "%%g" /F >NUL 2>&1
)

FOR /F "usebackq delims=" %%g in ("%TEMP%\reglocs_pkgs.dat") DO ( REG QUERY "%%g" 2>NUL>>"%TEMP%\privwindozelogp.txt" )
REG QUERY "HKLM\SYSTEM\Setup\Upgrade\Appx\DownlevelGather\AppxAllUserStore\%SID%" 2>NUL>>"%TEMP%\privwindozelogp.txt"
GREP -Eis "Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp2_found.txt"
GREP -Eis "MicrosoftWindows\.(Client\.WebExperience|LKG\.DesktopSpotlight)|MicrosoftCorporationII\.(QuickAssist|WinAppRuntime)|LenovoCompanion|CortanaUI" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp2_found.txt"
GREP -Eis "acerincorporated|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp2_found.txt"

SORT_ -f -u <"%TEMP%\privwindozelogp2_found.txt" >"%TEMP%\privwindozelogp2_del.txt"
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelogp2_del.txt") DO (
   SET "regpath=%%g"
   SETLOCAL EnableDelayedExpansion
   ECHO("!regpath!" ^(Registry Key^)>>"%TEMP%\004"
   REG DELETE "!regpath!" /F >NUL 2>&1
   ENDLOCAL
)

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
IF ERRORLEVEL 1 ( GOTO :EdgeAutoLaunch )
SED -r "s/^\s+(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\})\s+REG_SZ\s+v.*\|App=([A-Za-z]:.*\.exe).*\|$/\1     \2/" <"%TEMP%\privwindozelog2.txt" >"%TEMP%\privwindozelog3.txt"
SED -r "s/^(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}).*/\1/" <"%TEMP%\privwindozelog3.txt" >"%TEMP%\privwindozelog3clsids.txt"
SED -r "s/^.*\s{5}([A-Za-z]:.*\.exe)$/\1/" <"%TEMP%\privwindozelog3.txt" >"%TEMP%\privwindozelog3paths.txt"
FOR /F %%g in (%TEMP%\privwindozelog3clsids.txt) DO (
    FOR /F "usebackq delims=" %%i in ("%TEMP%\privwindozelog3paths.txt") DO (
    SET "firewallpath=%%i"
    SETLOCAL EnableDelayedExpansion
    IF NOT EXIST "!firewallpath!" (
                                     ECHO(HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules\\%%g -^> "!firewallpath!" ^(No File^)>>"%TEMP%\004"
                                     REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /V %%g /F >NUL 2>&1
                                    )
    ENDLOCAL
    )
)
:EdgeAutoLaunch
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>NUL|GREP -Eis "MicrosoftEdgeAutoLaunch_[A-F0-9]{32}">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :SubscribedContent )
SED -r "s/^\s{4}(MicrosoftEdgeAutoLaunch_[A-F0-9]{32})\s+REG_SZ\s+.*/\1/" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /F %%g in (%TEMP%\privwindozelogr2.txt) DO (
    ECHO(HKCU\Software\Microsoft\Windows\CurrentVersion\Run\\%%g ^(Registry Value^)>>"%TEMP%\004"
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%g" /F >NUL 2>&1
)
:SubscribedContent
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" 2>NUL|GREP -Eis "SubscribedContent-[0-9]{5,}Enabled">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}(SubscribedContent-[0-9]{5,}Enabled)\s+REG_DWORD\s+.*/\1/" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /F %%g in (%TEMP%\privwindozelogr2.txt) DO (
    ECHO(HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\\%%g ^(Registry Value^)>>"%TEMP%\004"
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "%%g" /F >NUL 2>&1
)


:: POLICIES ::
:Policies
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /T REG_DWORD /V Enabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V ContentDeliveryAllowed /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V FeatureManagementEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V OemPreInstalledAppsEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V PreInstalledAppsEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V PreInstalledAppsEverEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V RotatingLockScreenEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V RotatingLockScreenOverlayEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V SilentInstalledAppsEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V SoftLandingEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V SubscribedContentEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V SystemPaneSuggestionsEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /T REG_DWORD /V ShowedToastAtLevel /D 1 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /T REG_DWORD /V ShowSyncProviderNotifications /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /T REG_DWORD /V ScoobeSystemSettingEnabled /D 0 /F >NUL 2>&1
REG ADD "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /T REG_DWORD /V DisableMFUTracking /D 1 /F >NUL 2>&1
REG ADD "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1
REG ADD "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /T REG_DWORD /V TurnOffWindowsCopilot /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\System\AllowTelemetry" /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\WindowsAI\TurnOffWindowsCopilot" /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V AllowTelemetry /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V MaxTelemetryAllowed /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\EdgeUI" /T REG_DWORD /V DisableMFUTracking /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /T REG_DWORD /V DontSendAdditionalData /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\WindowsAI" /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1


:: TASKS ::
Echo([^|^|^|^|  ] Scanning Tasks
FOR %%g in (
"HPOneAgentRepairTask"
"HP\Consent Manager Launcher"
"Hewlett-Packard\HP Support Assistant\HP Support Assistant Update Notice"
"Intel\Intel Telemetry 3"
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
"MSI_GamebarConnect"
"MSI_GamebarTool"
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
"Microsoft\Office\Office 15 Subscription Heartbeat"
"Microsoft\Office\OfficeTelemetryAgentFallBack2016"
"Microsoft\Office\OfficeTelemetryAgentLogOn2016"
) DO (
       SCHTASKS /DELETE /TN %%g /F >NUL 2>&1
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
FOR /F %%g in (%TEMP%\svc_stop_disable.dat) DO (
    SC CONFIG "%%g" start= disabled>nul
    SC STOP "%%g">nul
)
FOR /F %%g in (%TEMP%\svc_delete.dat) DO (
    SC DELETE "%%g">nul
)

:EdgeService
REG QUERY "HKLM\SYSTEM\CurrentControlSet\services" 2>NUL>"%TEMP%\privwindozesvc.txt"
SED -r "s/^HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\//" <"%TEMP%\privwindozesvc.txt" >"%TEMP%\privwindozesvc2.txt"
GREP -Eis "^edgeupdate.*" <"%TEMP%\privwindozesvc2.txt" >"%TEMP%\privwindozesvc2_found.txt"
IF ERRORLEVEL 1 ( GOTO :DiscordFiles )
SORT_ -f -u <"%TEMP%\privwindozesvc2_found.txt" >"%TEMP%\privwindozesvc2_del.txt"
FOR /F %%g in (%TEMP%\privwindozesvc2_del.txt) DO (
    SC CONFIG %%g start= disabled>nul
    SC STOP %%g>nul
    SC DELETE %%g>nul    
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
    IF EXIST "!LOCALLOW!\!locallow64hex!" (
            ECHO("!LOCALLOW!\!locallow64hex!" ^(File^)>>"%TEMP%\001"
            DEL /F/Q "!LOCALLOW!\!locallow64hex!" >NUL 2>&1
            )
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
IF ERRORLEVEL 1 ( GOTO :Localpackages )
FOR /F %%g in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%SYS32%\config\systemprofile\AppData\Local\%%g" >NUL 2>&1
)
:Localpackages
DIR /B/A:D "%LOCALA%\Packages" 2>NUL>"%TEMP%\privwindozelogp.txt"
IF ERRORLEVEL 1 ( GOTO :Rootkits )
GREP -Eis "^Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <"%TEMP%\privwindozelogp.txt" >"%TEMP%\privwindozelogp_found.txt"
GREP -Eis "^MicrosoftWindows\.(Client\.WebExperience|LKG\.DesktopSpotlight)|^MicrosoftCorporationII\.(QuickAssist|WinAppRuntime)|LenovoCompanion|CortanaUI" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp_found.txt"
GREP -Eis "^(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp_found.txt"
SORT_ -f -u <"%TEMP%\privwindozelogp_found.txt" >"%TEMP%\privwindozelogp_del.txt"
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelogp_del.txt") DO (
    SET "packages=%%g"
    SETLOCAL EnableDelayedExpansion
    IF EXIST "!LOCALA!\Packages\!packages!" (
                                              ECHO("!LOCALA!\Packages\!packages!" ^(Folder^)>>"%TEMP%\001b"
                                              RD /S/Q "!LOCALA!\Packages\!packages!" >NUL 2>&1
                                              )
    ENDLOCAL
)
:Rootkits
IF NOT EXIST %SYS32%\pnputil.exe ECHO pnputil.exe is missing! && GOTO :Files
%SYS32%\pnputil.exe /enum-drivers 2>NUL|GREP -Es "^Original Name">"%TEMP%\privwindozelogrk.txt"
IF ERRORLEVEL 1 ( GOTO :Files )
SED -r "s/^Original Name.\s{4,}//" <"%TEMP%\privwindozelogrk.txt" >"%TEMP%\privwindozelogrk2.txt"
SORT_ -f -u <"%TEMP%\privwindozelogrk2.txt" >"%TEMP%\privwindozelogrk3.txt"
GREP -Eis "^(hp(analytics|customcap)comp\.inf|lenovoyx[x|8]0\.inf)$" <"%TEMP%\privwindozelogrk3.txt" >"%TEMP%\privwindozelogrk4.txt"
IF ERRORLEVEL 1 ( GOTO :Files )
:: NIRCMD BEEP 1400 50
FOR /F %%g in (%TEMP%\privwindozelogrk4.txt) DO (
    Echo(%%g ^(Driver^)>>"%TEMP%\000"
    %SYS32%\pnputil.exe /delete-driver %%g /uninstall /force >NUL 2>&1
)

:Files

IF EXIST %SYS32%\CertUtil.exe %SYS32%\CertUtil.exe -urlcache * delete>NUL
IF NOT EXIST %SYS32%\wevtutil.exe GOTO :Files2
%SYS32%\wevtutil.exe el|GREP -Es "^(Application|Security|Setup|System|ForwardedEvents)$">"%TEMP%\privwindozelogcl.txt"
FOR /F %%g in (%TEMP%\privwindozelogcl.txt) DO ( %SYS32%\wevtutil.exe cl %%g>NUL )
     
:Files2
FOR %%g in (
"%SYS32%\drivers\Intel\ICPS\IntelAnalyticsService.exe"
"%SYS32%\drivers\Lenovo\udc\Service\UDClientService.exe"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Desktop\Microsoft Teams.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS17%\OneDrive.lnk"
"%PROGRAMS27%\Microsoft Corporation\Microsoft Teams.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PROGRAMS27%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%ALLUSERSPROFILE%\Package Cache\{A59BC4A0-0F57-4F97-95E4-641AB5C3A9B0}\HPOneAgent.exe"
"%APPDATA%\Slate Digital Connect\SDACollector\sdaCollector.vbs"
) DO (
       IF EXIST %%g (
                      ECHO(%%g ^(File^)>>"%TEMP%\001"
                      DEL /F/Q %%g >NUL 2>&1
                      )
)
    
FOR %%g in (
"%LOCALA%\AMDIdentifyWindow\cache\qmlcache\*"
"%LOCALA%\AMDSoftwareInstaller\cache\qmlcache\*"
"%LOCALA%\AMD\DxCache\*"
"%LOCALA%\AMD\DxcCache\*"
"%LOCALA%\AMD\VkCache\*"
"%SYS32%\config\systemprofile\AppData\Local\AMD\DxCache\*"
"%SYS32%\config\systemprofile\AppData\Local\AMD\DxcCache\*"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\AMD\DxCache\*"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache\*"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Temp\*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCache\*"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Temp\*"
"%WINDIR%\SystemTemp\*"
"%WINDIR%\Temp\*"
) DO (
      DEL /F/Q %%g >NUL 2>&1
)

FOR %%g in (
"%ALLUSERSPROFILE%\Intel Telemetry"
"%ALLUSERSPROFILE%\Microsoft OneDrive"
"%ALLUSERSPROFILE%\Microsoft\DiagnosticLogCSP"
"%ALLUSERSPROFILE%\Microsoft\EdgeUpdate"
"%APPDATA%\Microsoft\Teams"
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\Microsoft\BGAHelperLib"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\Teams"
"%LOCALA%\Microsoft\TeamsMeetingAdd-in"
"%LOCALA%\Microsoft\TeamsMeetingAddin"
"%LOCALA%\Microsoft\TeamsPresenceAddin"
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
"%USERPROFILE%\MicrosoftEdgeBackups"
"%WINDIR%\GameBarPresenceWriter"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\GameDVR"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\GameExplorer"
"%WINDIR%\ServiceProfiles\LocalService\OneDrive"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\GameDVR"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\GameExplorer"
"%WINDIR%\ServiceProfiles\NetworkService\OneDrive"
) DO (
       IF EXIST %%g (
                      ECHO(%%g ^(Folder^)>>"%TEMP%\001b"
                      RD /S/Q %%g >NUL 2>&1
                      )
)

:DoLog

Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"%TEMP%\pwindoze.txt"
Echo(PrivWindoze by Furtivex>>"%TEMP%\pwindoze.txt"
Echo(Version: 2.6.8 ^(11.17.2024^)>>"%TEMP%\pwindoze.txt"
Echo(Operating System: %OS% %ARCH%>>"%TEMP%\pwindoze.txt"
Echo(Ran by "%username%" ^("%COMPUTERNAME%"^) ^(%USERSTATUS%^) on %StartDate% at %StartTime%>>"%TEMP%\pwindoze.txt"
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
ECHO(Drivers^:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\000" (
  SORT_ -f -u <"%TEMP%\000" >"%TEMP%\000rdy"
  TYPE "%TEMP%\000rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Files^:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
  IF EXIST "%TEMP%\001" (
  SORT_ -f -u <"%TEMP%\001" >"%TEMP%\001_rdy"
  TYPE "%TEMP%\001_rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Folders^:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\001b" (
  SORT_ -f -u <"%TEMP%\001b" >"%temp%\001brdy"
  TYPE "%TEMP%\001brdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Tasks^:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\002" (
  SORT_ -f -u <"%TEMP%\002" >"%TEMP%\002rdy"
  TYPE "%TEMP%\002rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Packages^:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\003" (
  SORT_ -f -u <"%TEMP%\003" >"%temp%\003rdy"
  TYPE "%TEMP%\003rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Registry^:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\004" (
  SORT_ -f -u <"%TEMP%\004" >"%temp%\004rdy"
  TYPE "%TEMP%\004rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%TEMP%\pwindoze.txt"
Echo(Scan was completed on %date% at %time%>>"%TEMP%\pwindoze.txt"
Echo(End of PrivWindoze log>>"%TEMP%\pwindoze.txt"
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%TEMP%\pwindoze.txt"
SED "s/\x22//g; s/Sysnative/system32/; s/HKEY_LOCAL_MACHINE/HKLM/; s/HKEY_CURRENT_USER/HKCU/; s/HKEY_CLASSES_ROOT/HKCR/" <"%TEMP%\pwindoze.txt" >"%USERPROFILE%\Desktop\PrivWindoze.txt"


:ClearTemp
DIR /B/A:-D "%TEMP%\*" 2>NUL|GREP -Esv "PrivWindoze\.bat$">"%TEMP%\privwindozelog.txt"
FOR /F "usebackq delims=" %%g in ("%TEMP%\privwindozelog.txt") DO (
    SET "deltemp=%%g"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!TEMP!\!deltemp!" >NUL 2>&1
    ENDLOCAL
)
RD /S/Q "%TEMP%\dependencies" >NUL 2>&1
ECHO.
ECHO.
START /D "%userprofile%" /I %WINDIR%\explorer.exe
ECHO(Scan completed. A log can be found on your Desktop.
TIMEOUT /t 05>NUL && DEL /F/Q "%TEMP%\PrivWindoze.bat">NUL 2>&1
:eof