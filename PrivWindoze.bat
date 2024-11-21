:: PrivWindoze
:: Created by Furtivex
@SETLOCAL
@CD /D "%~dp0"
@ECHO OFF
SET DEBUG=IFF
COLOR 17
TITLE .
DEL /A/F/Q "%TEMP%\*" >NUL 2>&1
IF NOT EXIST %systemdrive%\PrivWindoze MD %systemdrive%\PrivWindoze >NUL 2>&1
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
FOR %%G in (
grep.exe
libiconv2.dll
libintl3.dll
pcre3.dll
regex2.dll
sed.exe
sort_.exe
) DO ( COPY /Y "%CD%\dependencies\%%G" "%WINDIR%" >NUL 2>&1 )

FOR %%G in (
proc_kill.dat
svc_delete.dat
svc_stop_disable.dat
reglocs_pkgs.dat
Urunkey.cfg
NULL
regbad.dat
) DO ( COPY /Y "%CD%\%%G" %systemdrive%\PrivWindoze >NUL 2>&1 )
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
SET "PUBLIC=%SYSTEMDRIVE%\Users\Public"
SET "QUICKLAUNCH17=%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
SET "QUICKLAUNCH27=%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
SET "STARTMENU17=%ALLUSERSPROFILE%\Microsoft\windows\Start Menu"
SET "STARTMENU27=%APPDATA%\Microsoft\Windows\Start Menu"
SET "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
SET "URun=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
SET "StartupApprovedRun=HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
SET "CUCDM=HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
SET "WTASKS=%WINDIR%\Tasks"

FOR /F "tokens=2*" %%A IN ('REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName 2^>NUL') DO SET COMPUTERNAME=%%B
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>NUL') DO SET OS=%%B
Set StartDate=%date%
set StartTime=%time%

whoami /user>"%TEMP%\privwindozelogwho.txt"
GREP -Es "S-1-5-21-[0-9]{10}-[0-9]{10}-[0-9]{10}-[0-9]{3,4}$" <"%TEMP%\privwindozelogwho.txt" >"%TEMP%\privwindozelogwho2.txt"
IF ERRORLEVEL 1 ( GOTO :AdminChk )
SED -r "s/^.*(S-1-5-21-[0-9]{10}-[0-9]{10}-[0-9]{10}-[0-9]{3,4})$/\1/" <"%TEMP%\privwindozelogwho2.txt" >"%TEMP%\privwindozelogwho3.txt"
FOR /F %%G in (%TEMP%\privwindozelogwho3.txt) DO ( SET SID=%%G )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
ECHO.PrivWindoze Scan Started
ECHO.
ECHO.
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

FOR %%G in (
grep.exe
libiconv2.dll
libintl3.dll
pcre3.dll
regex2.dll
sed.exe
sort_.exe
) DO ( IF NOT EXIST %WINDIR%\%%G GOTO :eof )

FOR %%G in (
proc_kill.dat
svc_delete.dat
svc_stop_disable.dat
reglocs_pkgs.dat
Urunkey.cfg
NULL
regbad.dat
) DO ( IF NOT EXIST %systemdrive%\PrivWindoze\%%G GOTO :eof )

:: Create System Restore Point
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe ECHO Powershell.exe is missing! && GOTO :Processes
POWERSHELL -command "Checkpoint-Computer -Description 'PrivWindoze' -RestorePointType 'MODIFY_SETTINGS'"

:: PROCESSES ::
:Processes
Echo([^|     ] Scanning Processes
@FOR /F "TOKENS=*" %%G IN ( proc_kill.dat ) DO @TASKKILL /F /IM "%%G" >NUL 2>&1

:: PACKAGES ::
:Packages
Echo([^|^|    ] Scanning Packages
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe ECHO Powershell.exe is missing! && GOTO :Recall
POWERSHELL -command "Get-AppxPackage -AllUsers | Format-List -Property PackageFullName">"%TEMP%\privwindozeloga.txt"
SED -r "s/^PackageFullName : //" <"%TEMP%\privwindozeloga.txt" >"%TEMP%\privwindozeloga2.txt"
GREP -Eis "^Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <"%TEMP%\privwindozeloga2.txt" >"%TEMP%\privwindozeloga2_found.txt"
GREP -Eis "^MicrosoftWindows\.Client\.WebExperience|^MicrosoftCorporationII\.(QuickAssist|WinAppRuntime|MicrosoftFamily)|LenovoCompanion|CortanaUI" <"%TEMP%\privwindozeloga2.txt" >>"%TEMP%\privwindozeloga2_found.txt"
GREP -Eis "^(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)" <"%TEMP%\privwindozeloga2.txt" >>"%TEMP%\privwindozeloga2_found.txt"
GREP -Evs "^(Microsoft\.XboxGameCallableUI|Microsoft\.MicrosoftEdgeDevToolsClient)" <"%TEMP%\privwindozeloga2_found.txt" >"%TEMP%\privwindozeloga2_found2.txt"
SORT_ -f -u <"%TEMP%\privwindozeloga2_found2.txt" >"%TEMP%\privwindozeloga2_del.txt"
FOR /F %%G in (%TEMP%\privwindozeloga2_del.txt) DO (
    Echo(%%G ^(Package^)>>"%TEMP%\003"
    POWERSHELL -command "Remove-AppxPackage -AllUsers -Package %%G" >NUL 2>&1
)

:Recall
REM 24H2 Update
IF NOT EXIST %SYS32%\Dism.exe ECHO Dism.exe is missing! && GOTO :Registry
%SYS32%\Dism.exe /Online /Disable-Feature /Featurename:Recall>NUL
REM DISM /Online /Cleanup-Image /CheckHealth (other useful command)

:: REGISTRY ::
:Registry
Echo([^|^|^|   ] Scanning Registry
@FOR /F "TOKENS=*" %%G IN ( regbad.dat ) DO @REG QUERY "%%G" 2>NUL|GREP -Es "^HKEY_" >>temp00
FOR /F "TOKENS=*" %%G IN ( temp00 ) DO @(
  ECHO.%%G ^(Registry Key^) >>"%TEMP%\004"
  REG DELETE "%%G" /F >NUL 2>&1
  )
DEL /A/F/Q temp0? >NUL 2>&1

:: icacls %%G /grant "%username%":(d,wdac)
REM ~~~~~ NON MALWARE ENTRIES ~~~~~~~\/
REG DELETE "HKCR\.htm\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.html\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCR\.mht\OpenWithProgids" /V MSEdgeMHT /F >NUL 2>&1
REG DELETE "HKCR\.pdf\OpenWithProgids" /V MSEdgePDF /F >NUL 2>&1
REG DELETE "HKCR\.shtml\OpenWithProgids" /V MSEdgeHTM /F >NUL 2>&1
REG DELETE "HKCU\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V OneDriveSetup /F >NUL 2>&1
REG DELETE "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /VA /F >NUL 2>&1
REG DELETE %URun% /V Microsoft.Lists /F >NUL 2>&1
REG DELETE %URun% /V OneDrive /F >NUL 2>&1
REG DELETE %URun% /V com.slatedigital.analytics /F >NUL 2>&1
REG DELETE %URun% /V com.squirrel.Teams.Teams /F >NUL 2>&1
REG DELETE %URun% /V LenovoVantageToolbar /F >NUL 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V OneDrive /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION" /V OneDrive.exe /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V HPOneAgentService /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V TeamsMachineInstaller /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /V XboxStat /F >NUL 2>&1
REG DELETE "HKLM\Software\RegisteredApplications" /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Environment" /V OneDrive /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V OneDrive /F >NUL 2>&1
REG DELETE "HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V OneDriveSetup /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Environment" /V OneDrive /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V OneDrive /F >NUL 2>&1
REG DELETE "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce" /V OneDriveSetup /F >NUL 2>&1
REM ~~~~~ NON MALWARE ENTRIES ~~~~~~~/\

REM ~~~~~ START OF MALWARE ~~~~~~~\/
:CRUN
REG QUERY %URun% 2>NUL|GREP -s "    REG_SZ    ">"%TEMP%\_crun"
IF ERRORLEVEL 1 ( GOTO :XboxHuer )
SED -r "s/^\s{4}(.*)\s{4}REG_SZ\s{4}(.*)$/\1 ===> \2/" <"%TEMP%\_crun" >"%TEMP%\_crunboth"
SED -r "s/^(.*)\s===>.*/\1/" <"%TEMP%\_crunboth" >"%TEMP%\_crunonlykey"
SED -r "s/^.*===>\s(\x22.*)$/\1/" <"%TEMP%\_crunboth" >"%TEMP%\_crunonlypath"
FOR /F "usebackq delims=" %%G in ( Urunkey.cfg ) DO (
    REG QUERY %URUN% /V "%%G" >NUL 2>&1
    IF NOT ERRORLEVEL 1 (
                           ECHO(%URUN%\\"%%G" ^(Registry Value^)>>"%TEMP%\004"
                           REG DELETE %URUN% /V "%%G" /F >NUL 2>&1
                          )
)

REM :StartupApprovedRun
REM REG QUERY %StartupApprovedRun% 2>NUL|GREP -s "    REG_BINARY    ">"%TEMP%\_crun"
REM IF ERRORLEVEL 1 ( GOTO :XboxHuer )
REM SED -r "s/^\s{4}(.*)\s{4}REG_BINARY\s{4}(0[2|3]).*$/\1 ===> \2/" <"%TEMP%\_crun" >"%TEMP%\_crunboth"
REM SED -r "s/^(.*)\s===>.*/\1/" <"%TEMP%\_crunboth" >"%TEMP%\_crunonlykey"
REM SED -r "s/^.*===>\s(\x22.*)$/\1/" <"%TEMP%\_crunboth" >"%TEMP%\_crunonlypath"
REM FOR /F "usebackq delims=" %%G in ("%TEMP%\Urunkey.cfg") DO (
REM    REG QUERY %StartupApprovedRun% /V "%%G" >NUL 2>&1
REM    IF NOT ERRORLEVEL 1 (
REM                           ECHO(%StartupApprovedRun%\\"%%G" ^(Registry Value^)>>"%TEMP%\004"
REM                           REG DELETE %StartupApprovedRun% /V "%%G" /F >NUL 2>&1
REM                          )
REM )

:XboxHuer
REG QUERY HKCR 2>NUL|GREP -Eis "^HKEY_CLASSES_ROOT\\(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">"%TEMP%\privwindozelogh.txt"
REG QUERY HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol 2>NUL|GREP -Eis "(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">>"%TEMP%\privwindozelogh.txt"
REG QUERY HKLM\Software\Microsoft\Tracing 2>NUL|GREP -Es "RAS[A-Z0-9]{5}$">>"%TEMP%\privwindozelogh.txt"
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelogh.txt") DO (
   ECHO("%%G" ^(Registry Key^)>>"%TEMP%\004"
   REG DELETE "%%G" /F >NUL 2>&1
)

@FOR /F "TOKENS=*" %%G IN ( reglocs_pkgs.dat ) DO @REG QUERY "%%G" 2>NUL>>temp00
REG QUERY "HKLM\SYSTEM\Setup\Upgrade\Appx\DownlevelGather\AppxAllUserStore\%SID%" 2>NUL>>temp00
REG QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\%SID%" 2>NUL>>temp00
GREP -Eis "Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <temp00 >temp01
GREP -Eis "MicrosoftWindows\.(Client\.WebExperience|LKG\.DesktopSpotlight)|MicrosoftCorporationII\.(QuickAssist|WinAppRuntime|MicrosoftFamily)|LenovoCompanion|CortanaUI" <temp00 >>temp01
GREP -Eis "acerincorporated|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames" <temp00 >>temp01
SORT_ -f -u <temp01 >temp02
IF EXIST temp02 (
  FOR /F "TOKENS=*" %%G IN ( temp02 ) DO @(
    ECHO.%%G ^(Registry Key^) >>"%TEMP%\004"
    REG DELETE "%%G" /F >NUL 2>&1
    ) )
DEL /A/F/Q temp0? >NUL 2>&1

REG QUERY "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"|GREP -Es "    \{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}" >temp00
IF ERRORLEVEL 1 ( GOTO :FirewallOrphans )
GREP -Es "Name=Microsoft Edge|Name=@\{Microsoft\.(Bing|Todos|Xbox|Zune)|Name=@\{Clipchamp\." <temp00 >temp01
IF ERRORLEVEL 1 ( GOTO :FirewallOrphans )
SED -r "s/^\s+(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}).*/\1/" <temp01 >temp02
IF EXIST temp02 (
  FOR /F "TOKENS=*" %%G IN ( temp02 ) DO @REG DELETE HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules /V "%%G" /F >NUL 2>&1
  )
DEL /A/F/Q temp0? >NUL 2>&1

:FirewallOrphans
GREP -Es "\|App=[A-Za-z]:.*\.exe" <temp00 >temp01
IF ERRORLEVEL 1 ( GOTO :EdgeAutoLaunch )
SED -r "s/^\s+(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\})\s+REG_SZ\s+v.*\|App=([A-Za-z]:.*\.exe).*\|$/\1     \2/" <temp01 >"%TEMP%\fwall.txt"
SED -r "s/^(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}).*/\1/" <"%TEMP%\fwall.txt" >"%TEMP%\fwallclsids.txt"
SED -r "s/^.*\s{5}([A-Za-z]:.*\.exe)$/\1/" <"%TEMP%\fwall.txt" >"%TEMP%\fwallpaths.txt"
FOR /F %%G in (%TEMP%\fwallclsids.txt) DO (
    FOR /F "usebackq delims=" %%i in ("%TEMP%\fwallpaths.txt") DO (
    SET "firewallpath=%%i"
    SETLOCAL EnableDelayedExpansion
    IF NOT EXIST "!firewallpath!" (
                                     ECHO(HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules\\%%G -^> "!firewallpath!" ^(No File^)>>"%TEMP%\004"
                                     REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /V %%G /F >NUL 2>&1
                                    )
    ENDLOCAL
    )
)
DEL /A/F/Q temp0? >NUL 2>&1
:EdgeAutoLaunch
REG QUERY "%URun%" 2>NUL|GREP -Eis "MicrosoftEdgeAutoLaunch_[A-F0-9]{32}">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :SubscribedContent )
SED -r "s/^\s{4}(MicrosoftEdgeAutoLaunch_[A-F0-9]{32})\s+REG_SZ\s+.*/\1/" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /F %%G in (%TEMP%\privwindozelogr2.txt) DO (
    ECHO(%URun%\\%%G ^(Registry Value^)>>"%TEMP%\004"
    REG DELETE "%URun%" /V "%%G" /F >NUL 2>&1
)
:SubscribedContent
REG QUERY %CUCDM% 2>NUL|GREP -Eis "SubscribedContent-[0-9]{5,}Enabled">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}(SubscribedContent-[0-9]{5,}Enabled)\s+REG_DWORD\s+.*/\1/" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /F %%G in (%TEMP%\privwindozelogr2.txt) DO (
    ECHO(%CUCDM%\\%%G ^(Registry Value^)>>"%TEMP%\004"
    REG DELETE %CUCDM% /V "%%G" /F >NUL 2>&1
)

:: POLICIES ::
:Policies
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /T REG_DWORD /V Enabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V ContentDeliveryAllowed /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V FeatureManagementEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V OemPreInstalledAppsEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V PreInstalledAppsEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V PreInstalledAppsEverEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V RotatingLockScreenEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V RotatingLockScreenOverlayEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V SilentInstalledAppsEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V SoftLandingEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V SubscribedContentEnabled /D 0 /F >NUL 2>&1
REG ADD %CUCDM% /T REG_DWORD /V SystemPaneSuggestionsEnabled /D 0 /F >NUL 2>&1
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
FOR %%G in (
"$nya-Loli"
"$nya-svc64"
"AsusFCNotification"
"DropboxSyncTaskMachineUA"
"Gtask"
"HPAudioSwitch"
"HPOneAgentRepairTask"
"HP\Consent Manager Launcher"
"Hewlett-Packard\HP Support Assistant\HP Support Assistant Update Notice"
"Hewlett-Packard\HP Support Assistant\WarrantyChecker"
"Hewlett-Packard\HP Support Assistant\WarrantyChecker_DeviceScan"
"Intel\Intel Telemetry 3"
"Lenovo\ImController\Lenovo iM Controller Monitor"
"Lenovo\ImController\Lenovo iM Controller Scheduled Maintenance"
"Lenovo\Lenovo Service Bridge\%SID%"
"Lenovo\LenovoNowLauncher"
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
"Lenovo\Vantage\Schedule\LenovoBoostAddin.Prompt"
"Lenovo\Vantage\Schedule\LenovoCompanionAppAddinDailyScheduleTask"
"Lenovo\Vantage\Schedule\LenovoSystemUpdateAddin_WeeklyTask"
"Lenovo\Vantage\Schedule\SettingsWidgetAddinDailyScheduleTask"
"Lenovo\Vantage\Schedule\SmartPerformance.ExpireReminder"
"Lenovo\Vantage\Schedule\VantageCoreAddinIdleScheduleTask"
"Lenovo\Vantage\Schedule\VantageCoreAddinWeekScheduleTask"
"Lenovo\Vantage\StartupFixPlan"
"MSI_GamebarConnect"
"MSI_GamebarTool"
"McAfeeTsk\OOBEUpgrader"
"McAfee\WPS\McAfee Anti-Tracker Scanner"
"McAfee\WPS\McAfee Anti-tracker notification"
"McAfee\WPS\McAfee Cloud Configuration Check"
"McAfee\WPS\McAfee Health Check"
"McAfee\WPS\McAfee Hotfix"
"McAfee\WPS\McAfee Message Check"
"McAfee\WPS\McAfee PC Optimizer Task"
"McAfee\WPS\McAfee Scheduled Tracker Remover"
"Microsoft\Office\Office 15 Subscription Heartbeat"
"Microsoft\Office\Office Performance Monitor"
"Microsoft\Office\OfficeTelemetryAgentFallBack"
"Microsoft\Office\OfficeTelemetryAgentFallBack2016"
"Microsoft\Office\OfficeTelemetryAgentLogOn"
"Microsoft\Office\OfficeTelemetryAgentLogOn2016"
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
"OneChecker"
"Samsung_PSSD_Registration_Plus"
"TVT\TVSUUpdateTask"
"TVT\TVSUUpdateTask_UserLogOn"
"UEIPInvitation"
"UbtFrameworkService"
"UniversalUpdater"
"Updater"
"Window Update"
"Windows Service Task"
"YT Storage Logon"
"dialersvc64"
"sonic"
) DO (
       SCHTASKS /DELETE /TN %%G /F >NUL 2>&1
)
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^MicrosoftEdgeUpdateTask">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :OneDriveTask )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:OneDriveTask
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^OneDrive">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :TelemetryTask )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:TelemetryTask
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -i "Telemetry">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :NvidiaTask )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:NvidiaTask
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -i "NvTmRep_">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :WindowsDefenderTask )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:WindowsDefenderTask
DIR /B "%SYS32%\Tasks\Microsoft\Windows\Windows Defender" 2>NUL|FINDSTR -ri "^Windows Defender">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Optimize )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Microsoft\Windows\Windows Defender\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Microsoft\Windows\Windows Defender\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:Optimize
DIR /B "%SYS32%\Tasks" 2>NUL|FINDSTR -ri "^Optimize Push Notification Data File">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :OmenHp )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:OmenHp
DIR /B "%SYS32%\Tasks" 2>NUL|GREP -Eis "^Omen(Install|Overlay)">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :TimeBasedEvents )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:TimeBasedEvents
DIR /B "%SYS32%\Tasks\Lenovo\ImController\TimeBasedEvents" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :UDCLen )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Lenovo\ImController\TimeBasedEvents\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Lenovo\ImController\TimeBasedEvents\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Lenovo\ImController\TimeBasedEvents\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:UDCLen
DIR /B "%SYS32%\Tasks\Lenovo\UDC\MessagingPlugin" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :UDCLen2 )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Lenovo\UDC\MessagingPlugin\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Lenovo\UDC\MessagingPlugin\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Lenovo\UDC\MessagingPlugin\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:UDCLen2
DIR /B "%SYS32%\Tasks\Lenovo\UDC\SystemNotificationPlugin" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :WDNA )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "Lenovo\UDC\SystemNotificationPlugin\!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\Lenovo\UDC\SystemNotificationPlugin\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\Lenovo\UDC\SystemNotificationPlugin\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:WDNA
DIR /B "%SYS32%\Tasks" 2>NUL|GREP -Eis "^WDNA_Updater[0-9]{3,}">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :YTHex )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:YTHex
DIR /B "%SYS32%\Tasks" 2>NUL|GREP -Es "^YT[a-f0-9]{8,}">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :ICTorrent )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:ICTorrent
DIR /B "%SYS32%\Tasks" 2>NUL|GREP -Eis "^ICTorrent">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Services )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "taskname=%%G"
    SETLOCAL EnableDelayedExpansion
    SCHTASKS /DELETE /TN "!taskname!" /F >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks\!taskname!" >NUL 2>&1
    DEL /F/Q "!SYS32!\Tasks_Migrated\!taskname!" >NUL 2>&1
    ENDLOCAL
)
:Services
Echo([^|^|^|^|^| ] Scanning Services
FOR /F %%G in ( svc_stop_disable.dat ) DO (
    SC CONFIG "%%G" start= disabled>nul
    SC STOP "%%G">nul
)
FOR /F %%G in ( svc_delete.dat ) DO (
    SC DELETE "%%G">nul
)
:EdgeService
REG QUERY "HKLM\SYSTEM\CurrentControlSet\services" 2>NUL>"%TEMP%\privwindozesvc.txt"
SED -r "s/^HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\//" <"%TEMP%\privwindozesvc.txt" >"%TEMP%\privwindozesvc2.txt"
GREP -Eis "^edgeupdate.*" <"%TEMP%\privwindozesvc2.txt" >"%TEMP%\privwindozesvc2_found.txt"
IF ERRORLEVEL 1 ( GOTO :DiscordFiles )
SORT_ -f -u <"%TEMP%\privwindozesvc2_found.txt" >"%TEMP%\privwindozesvc2_del.txt"
FOR /F %%G in (%TEMP%\privwindozesvc2_del.txt) DO (
    SC CONFIG %%G start= disabled>nul
    SC STOP %%G>nul
    SC DELETE %%G>nul    
)
:DiscordFiles
Echo([^|^|^|^|^|^|] Scanning File System
DIR /B "%APPDATA%\discord\Code Cache\js" 2>NUL|FINDSTR -ri "^[a-f0-9].*_0$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Discord2 )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "discord=%%G"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Code Cache\js\!discord!" >NUL 2>&1
    ENDLOCAL
)
:Discord2
DIR /B "%APPDATA%\discord\Cache\Cache_Data" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :locallow64hex )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "discord=%%G"
    SETLOCAL EnableDelayedExpansion
    DEL /F/Q "!APPDATA!\discord\Cache\Cache_Data\!discord!" >NUL 2>&1
    ENDLOCAL
)
:locallow64hex
DIR /B/A:-D "%LOCALLOW%" 2>NUL|GREP -Es "^[a-f0-9]{64}$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :InboxApps )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "locallow64hex=%%G"
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
FOR /F %%G in (%TEMP%\privwindozelog.txt) DO (
    DEL /F/Q "%WINDIR%\InboxApps\%%G" >NUL 2>&1
)
:D3DSCache
DIR /B/A:D "%LOCALA%\D3DSCache" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :D3DSCache2 )
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelog.txt") DO (
    SET "cache=%%G"
    SETLOCAL EnableDelayedExpansion
    RD /S/Q "!LOCALA!\D3DSCache\!cache!" >NUL 2>&1
    ENDLOCAL
)
:D3DSCache2
DIR /B/A:D "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :D3DSCache3 )
FOR /F %%G in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache\%%G" >NUL 2>&1
)
:D3DSCache3
DIR /B/A:D "%SYS32%\config\systemprofile\AppData\Local\D3DSCache" 2>NUL>"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Twtmp )
FOR /F %%G in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%SYS32%\config\systemprofile\AppData\Local\D3DSCache\%%G" >NUL 2>&1
)
:Twtmp
DIR /B/A:D "%SYS32%\config\systemprofile\AppData\Local" 2>NUL|GREP -Es "^tw-[a-f0-9]{2,}-[a-f0-9]{2,}-[a-f0-9]{2,}\.tmp$">"%TEMP%\privwindozelog.txt"
IF ERRORLEVEL 1 ( GOTO :Localpackages )
FOR /F %%G in (%TEMP%\privwindozelog.txt) DO (
    RD /S/Q "%SYS32%\config\systemprofile\AppData\Local\%%G" >NUL 2>&1
)
:Localpackages
DIR /B/A:D "%LOCALA%\Packages" 2>NUL>"%TEMP%\privwindozelogp.txt"
IF ERRORLEVEL 1 ( GOTO :Rootkits )
GREP -Eis "^Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <"%TEMP%\privwindozelogp.txt" >"%TEMP%\privwindozelogp_found.txt"
GREP -Eis "^MicrosoftWindows\.(Client\.WebExperience|LKG\.DesktopSpotlight)|^MicrosoftCorporationII\.(QuickAssist|WinAppRuntime|MicrosoftFamily)|LenovoCompanion|CortanaUI" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp_found.txt"
GREP -Eis "^(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp_found.txt"
SORT_ -f -u <"%TEMP%\privwindozelogp_found.txt" >"%TEMP%\privwindozelogp_del.txt"
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelogp_del.txt") DO (
    SET "packages=%%G"
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
FOR /F %%G in (%TEMP%\privwindozelogrk4.txt) DO (
    Echo(%%G ^(Driver^)>>"%TEMP%\000"
    %SYS32%\pnputil.exe /delete-driver %%G /uninstall /force >NUL 2>&1
)

:Files

IF EXIST %SYS32%\CertUtil.exe %SYS32%\CertUtil.exe -urlcache * delete>NUL
IF NOT EXIST %SYS32%\wevtutil.exe GOTO :Files2
%SYS32%\wevtutil.exe el|GREP -Es "^(Application|Security|Setup|System|ForwardedEvents)$">"%TEMP%\privwindozelogcl.txt"
FOR /F %%G in (%TEMP%\privwindozelogcl.txt) DO ( %SYS32%\wevtutil.exe cl %%G>NUL )
     
:Files2

DIR /B/A:-D "%ALLUSERSPROFILE%" 2>NUL>allusersprofile
DIR /B/A:-D "%APPDATA%" 2>NUL>appdata
DIR /B/A:-D "%LOCALA%" 2>NUL>locala
DIR /B/A:-D "%LOCALLOW%" 2>NUL>locallow
DIR /B/A:-D "%STARTUP%" 2>NUL>startup
DIR /B/A:-D "%SYS32%\config\systemprofile\AppData" 2>NUL>sys32appdata

GREP -Esi ".*\.(bat|cmd|dll|exe|js|pif|ps1|scr|tmp|vbe|vbs)$" <allusersprofile >allusersprofile2
FOR /F "TOKENS=*" %%G IN ( allusersprofile2 ) DO @(
  ECHO.%ALLUSERSPROFILE%\%%G ^(File^)>>"%TEMP%\001"
  DEL /A/F/Q "%ALLUSERSPROFILE%\%%G" >NUL 2>&1
  )

GREP -Esi ".*\.(bat|cmd|dll|exe|js|pif|ps1|scr|tmp|vbe|vbs)$" <appdata >appdata2
FOR /F "TOKENS=*" %%G IN ( appdata2 ) DO @(
  ECHO.%APPDATA%\%%G ^(File^)>>"%TEMP%\001"
  DEL /A/F/Q "%APPDATA%\%%G" >NUL 2>&1
  )
  
GREP -Esi ".*\.(bat|cmd|dll|exe|js|pif|ps1|scr|tmp|vbe|vbs)$" <locala >locala2
FOR /F "TOKENS=*" %%G IN ( locala2 ) DO @(
  ECHO.%LOCALA%\%%G ^(File^)>>"%TEMP%\001"
  DEL /A/F/Q "%LOCALA%\%%G" >NUL 2>&1
  )
  
GREP -Esi ".*\.(bat|cmd|dll|exe|js|pif|ps1|scr|tmp|vbe|vbs)$" <locallow >locallow2
FOR /F "TOKENS=*" %%G IN ( locallow2 ) DO @(
  ECHO.%LOCALLOW%\%%G ^(File^)>>"%TEMP%\001"
  DEL /A/F/Q "%LOCALLOW%\%%G" >NUL 2>&1
  )
  
GREP -Esi ".*\.(bat|cmd|dll|exe|js|pif|ps1|scr|tmp|vbe|vbs)$" <startup >startup2
FOR /F "TOKENS=*" %%G IN ( startup2 ) DO @(
  ECHO.%STARTUP%\%%G ^(File^)>>"%TEMP%\001"
  DEL /A/F/Q "%STARTUP%\%%G" >NUL 2>&1
  )
  
GREP -Esi ".*\.(bat|cmd|dll|exe|js|pif|ps1|scr|tmp|vbe|vbs)$" <sys32appdata >sys32appdata2
FOR /F "TOKENS=*" %%G IN ( sys32appdata2 ) DO @(
  ECHO.%SYS32%\config\systemprofile\AppData\%%G ^(File^)>>"%TEMP%\001"
  DEL /A/F/Q "%SYS32%\config\systemprofile\AppData\%%G" >NUL 2>&1
  )

FOR %%G in (
"%ALLUSERSPROFILE%\Package Cache\{A59BC4A0-0F57-4F97-95E4-641AB5C3A9B0}\HPOneAgent.exe"
"%APPDATA%\Gitl\mrucl.exe"
"%APPDATA%\ITEinboxI2CFlash\ITERHPGen.exe"
"%APPDATA%\ITEinboxI2CFlash\bckp_amgr.exe"
"%APPDATA%\Slate Digital Connect\SDACollector\sdaCollector.vbs"
"%APPDATA%\sonicstudio\sonic.exe"
"%LOCALA%\LavoshGri\php.exe"
"%LOCALA%\Updates\Run.vbs"
"%LOCALA%\Updates\WindowsService.exe"
"%LOCALA%\programs\common\taskshosts.exe"
"%LOCALA%\yzsx_cloud\wdcloud_v2.exe"
"%PROGRAMS17%\Microsoft Edge.lnk"
"%PROGRAMS17%\OneDrive.lnk"
"%PROGRAMS27%\Microsoft Corporation\Microsoft Teams.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%PROGRAMS27%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%PUBLIC%\Documents\Systeem.vbs"
"%STARTUP%\ITERHPGen.lnk"
"%STARTUP%\Microsoft.NET Framework.exe"
"%STARTUP%\SC.cmd"
"%STARTUP%\bckp_amgr.lnk"
"%STARTUP%\mrucl.lnk"
"%SYS32%\drivers\Intel\ICPS\IntelAnalyticsService.exe"
"%SYS32%\drivers\Lenovo\udc\Service\UDClientService.exe"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Desktop\Microsoft Teams.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%WINDIR%\$nya-onimai3\$nya-Loli.bat"
"%WTASKS%\Gtask.job"
) DO @(
  IF EXIST "%%G" (
    ECHO."%%G" ^(File^)>>"%TEMP%\001"
    DEL /A/F/Q %%G >NUL 2>&1
    )
)


FOR %%G in (
"%APPDATA%\obs-studio\logs\*"
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
) DO @DEL /A/F/Q "%%G" >NUL 2>&1

FOR %%G in (
"%ALLUSERSPROFILE%\Intel Telemetry"
"%ALLUSERSPROFILE%\Microsoft OneDrive"
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
"%PROGRAMFILES%\HP\OmenInstallMonitor"
"%PROGRAMFILES%\Intel\Telemetry 3.0"
"%PROGRAMFILES%\Microsoft OneDrive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES%\Tobii\Tobii EyeX"
"%PROGRAMFILES(x86)%\HP\HP Support Framework\Resources\BingPopup"
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
) DO @(
  IF EXIST %%G (
    ECHO.%%G ^(Folder^)>>"%TEMP%\001b"
    RD /S/Q %%G >NUL 2>&1
    )
)

:DoLog

Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"%TEMP%\pwindoze.txt"
Echo(PrivWindoze by Furtivex>>"%TEMP%\pwindoze.txt"
Echo(Version: 2.7.9 ^(11.21.2024^)>>"%TEMP%\pwindoze.txt"
Echo(Operating System: %OS% %ARCH%>>"%TEMP%\pwindoze.txt"
Echo(Ran by "%username%" ^("%COMPUTERNAME%"^) ^(%USERSTATUS%^) on %StartDate% at %StartTime%>>"%TEMP%\pwindoze.txt"
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
ECHO(Drivers:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\000" (
  SORT_ -f -u <"%TEMP%\000" >"%TEMP%\000rdy"
  TYPE "%TEMP%\000rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Files:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
  IF EXIST "%TEMP%\001" (
  SORT_ -f -u <"%TEMP%\001" >"%TEMP%\001_rdy"
  TYPE "%TEMP%\001_rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Folders:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\001b" (
  SORT_ -f -u <"%TEMP%\001b" >"%temp%\001brdy"
  TYPE "%TEMP%\001brdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Tasks:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\002" (
  SORT_ -f -u <"%TEMP%\002" >"%TEMP%\002rdy"
  TYPE "%TEMP%\002rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Packages:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\003" (
  SORT_ -f -u <"%TEMP%\003" >"%temp%\003rdy"
  TYPE "%TEMP%\003rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(Registry:>>"%TEMP%\pwindoze.txt"
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


RD /S/Q %systemdrive%\PrivWindoze\dependencies >NUL 2>&1
IF %DEBUG%==OFF @DEL %windir%\grep.exe %windir%\libiconv2.dll %windir%\libintl3.dll %windir%\pcre3.dll %windir%\regex2.dll %windir%\sed.exe %windir%\sort_.exe >NUL 2>&1
DEL /A/F/Q temp0? >NUL 2>&1
ECHO.
ECHO.
START /D "%userprofile%" /I %WINDIR%\explorer.exe
ECHO(Scan completed. A log can be found on your Desktop.
DEL /A/F/Q "%TEMP%\*" >NUL 2>&1
TIMEOUT /t 05>NUL && RD /S/Q %systemdrive%\PrivWindoze
:eof