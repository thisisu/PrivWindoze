:: PrivWindoze
:: Created by Furtivex
@ECHO OFF
@SETLOCAL
@PROMPT #
@CD /D "%~dp0"
SET DEBUG=OFF
COLOR 71
TITLE .
DEL /F/Q "%TEMP%\*" >NUL 2>&1
IF NOT EXIST %systemdrive%\PrivWindoze MD %systemdrive%\PrivWindoze >NUL 2>&1
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
FOR %%G in (
grep.exe
libiconv2.dll
libintl3.dll
nircmd.exe
pcre3.dll
regex2.dll
sed.exe
sort_.exe
) DO ( COPY /Y "%CD%\dependencies\%%G" "%WINDIR%" >NUL 2>&1 )

FOR %%G in (
NULL
regbad.cfg
reglocs_pkgs.cfg
svc_delete.cfg
svc_stop_disable.cfg
Urunkey.cfg
I4ng.bat
) DO ( COPY /Y "%CD%\%%G" %systemdrive%\PrivWindoze >NUL 2>&1 )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF EXIST %WINDIR%\Sysnative\cmd.exe (SET "SYS32=%WINDIR%\Sysnative") else (SET "SYS32=%WINDIR%\System32")
IF EXIST %WINDIR%\syswow64 (SET ARCH=x64) else (SET ARCH=x86)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "ALLUSERSPROFILE=%SYSTEMDRIVE%\ProgramData"
SET "APPDATA=%USERPROFILE%\AppData\Roaming"
SET "COMMON32=%SYSTEMDRIVE%\Program Files\Common Files"
SET "COMMON64=%SYSTEMDRIVE%\Program Files (x86)\Common Files"
SET "CUCDM=HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
SET "LOCALA=%USERPROFILE%\AppData\Local"
SET "LOCALLOW=%USERPROFILE%\AppData\LocalLow"
SET "PROGFILES32=%SYSTEMDRIVE%\Program Files"
SET "PROGFILES64=%SYSTEMDRIVE%\Program Files (x86)"
SET "PROGRAMSAUP=%SYSTEMDRIVE%\ProgramData\Microsoft\Windows\Start Menu\Programs"
SET "PROGRAMSCU=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
SET "PROGRAMS1ALL=%ALLUSERSPROFILE%\Start Menu\Programs"
SET "PROGRAMS2ALL=%USERPROFILE%\Start Menu\Programs"
SET "PUBDESKTOP=%SYSTEMDRIVE%\Users\Public\Desktop"
SET "PUBLIC=%SYSTEMDRIVE%\Users\Public"
SET "QUICKLAUNCHSM=%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
SET "QUICKLAUNCHTB=%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
SET "QUICKLAUNCH=%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch"
SET "STARTMENUAUP=%SYSTEMDRIVE%\ProgramData\Microsoft\windows\Start Menu"
SET "STARTMENUCU=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu"
SET "STARTUP=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
SET "StartupApprovedRun=HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
SET "STASKS=%SYSTEMDRIVE%\WINDOWS\System32\Tasks"
SET "URun=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
SET "URunOnce=HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
SET "WTASKS=%SYSTEMDRIVE%\WINDOWS\Tasks"
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
POWERSHELL -command "(Get-CimInstance -ClassName CIM_OperatingSystem).Caption">temp00
FOR /F "TOKENS=*" %%G IN ( temp00 ) DO SET OS=%%G
GREP -Esi "^Microsoft Windows [11|10]" <temp00 >"%TEMP%\%random%"
IF ERRORLEVEL 1 GOTO :Abort
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion 2^>NUL') DO SET DisplayVersion=%%B
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
@CALL I4ng.bat
ECHO.>"%TEMP%\ClickedNo"
NIRCMD QBOXCOMTOP "%DISCLAIMER%" "" FILLDELETE "%TEMP%\ClickedNo"
TIMEOUT /T 1 /NOBREAK >NUL
IF EXIST "%TEMP%\ClickedNo" GOTO :Abort
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
whoami /user>temp00
GREP -Es "S-1-5-21-[0-9]{10}-[0-9]{10}-[0-9]{10}-[0-9]{3,4}$" <temp00 >temp01
IF ERRORLEVEL 1 ( GOTO :AdminChk )
SED -r "s/^.*(S-1-5-21-[0-9]{10}-[0-9]{10}-[0-9]{10}-[0-9]{3,4})$/\1/" <temp01 >temp02
FOR /F %%G in (temp02) DO SET SID=%%G
DEL /F/Q temp0? >NUL 2>&1
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
:AdminChk
net session >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 GOTO :Abort

FOR %%G in (
grep.exe
libiconv2.dll
libintl3.dll
nircmd.exe
pcre3.dll
regex2.dll
sed.exe
sort_.exe
) DO ( IF NOT EXIST %WINDIR%\%%G GOTO :Abort )

FOR %%G in (
NULL
regbad.cfg
reglocs_pkgs.cfg
svc_delete.cfg
svc_stop_disable.cfg
Urunkey.cfg
I4ng.bat
) DO ( IF NOT EXIST %systemdrive%\PrivWindoze\%%G GOTO :Abort )

set h=%TIME:~0,2%
set m=%TIME:~3,2%
set s=%TIME:~6,2%
set mnth=%date:~4,2%
set day=%date:~7,2%
set yr=%date:~10,4%
set StartTime=%mnth%.%day%.%yr%_%h%.%m%.%s%

:: Create System Restore Point
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe ECHO Powershell.exe is missing! && GOTO :Processes
POWERSHELL -command "Checkpoint-Computer -Description 'PrivWindoze' -RestorePointType 'MODIFY_SETTINGS'" >NUL 2>&1
cls
ECHO.%Scan_ThereWillBeLog%
ECHO.
ECHO.
:License
IF EXIST %SYS32%\slmgr.vbs @(
  cscript /nologo %SYS32%\slmgr.vbs /dli|GREP -Es "^License Status">info00
  SED -r "s/^License Status: //" <info00 >info01
  FOR /F %%G in (info01) DO SET LicenseStatus=%%G
)
:: PROCESSES ::
:Processes
Echo([^|     ]
TASKKILL /F /IM explorer.exe >NUL 2>&1
TIMEOUT /T 2 /NOBREAK >NUL
TASKLIST /FO CSV /NH 2>NUL|GREP -Es "\.exe" >temp00
SED -r "s/^\x22(.*\.exe)\x22.*/\1/" <temp00 >temp01
SORT_ -f -u <temp01 >temp02
GREP -Eivs "^(audiodg|cmd|conhost|csrss|ctfmon|dllhost|dwm|fontdrvhost|iphlpsvc|LsaIso|lsass|MpDefenderCoreService|MsMpEng|MsSense|NisSrv|OpenConsole|RuntimeBroker|Search(host|Indexer)|services|SecHealthUI|SecurityHealthService|ShellExperienceHost|sihost|(CHX)?smartscreen|smss|spoolsv|StartMenuExperienceHost|svchost|task(kill|hostw)|TextInputHost|WindowsTerminal|wininit|winlogon|WmiPrvSE|WUDFHost)\.exe$" <temp02 >temp03
@FOR /F "TOKENS=*" %%G IN ( temp03 ) DO @TASKKILL /F /IM "%%G" >NUL 2>&1
DEL /F/Q temp0? >NUL 2>&1

:: PACKAGES ::
:Packages
Echo([^|^|    ]
IF NOT EXIST %SYS32%\WindowsPowerShell\v1.0\powershell.exe ECHO Powershell.exe is missing! && GOTO :Recall
POWERSHELL -command "Get-AppxPackage -AllUsers | Format-List -Property PackageFullName">"%TEMP%\privwindozeloga.txt"
SED -r "s/^PackageFullName : //" <"%TEMP%\privwindozeloga.txt" >"%TEMP%\privwindozeloga2.txt"
GREP -Eis "^Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MicrosoftPCManager|MicrosoftPCManager|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Teams|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <"%TEMP%\privwindozeloga2.txt" >"%TEMP%\privwindozeloga2_found.txt"
GREP -Eis "^MicrosoftWindows\.Client\.WebExperience|^MicrosoftCorporationII\.(QuickAssist|WinAppRuntime|MicrosoftFamily)|LenovoCompanion|CortanaUI" <"%TEMP%\privwindozeloga2.txt" >>"%TEMP%\privwindozeloga2_found.txt"
GREP -Eis "^(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)" <"%TEMP%\privwindozeloga2.txt" >>"%TEMP%\privwindozeloga2_found.txt"
GREP -Evs "^(Microsoft\.XboxGameCallableUI|Microsoft\.MicrosoftEdgeDevToolsClient)" <"%TEMP%\privwindozeloga2_found.txt" >"%TEMP%\privwindozeloga2_found2.txt"
SORT_ -f -u <"%TEMP%\privwindozeloga2_found2.txt" >"%TEMP%\privwindozeloga2_del.txt"
FOR /F %%G in (%TEMP%\privwindozeloga2_del.txt) DO (
    Echo(%%G>>"%TEMP%\003"
    POWERSHELL -command "Remove-AppxPackage -AllUsers -Package %%G" >NUL 2>&1
)

:Recall
REM 24H2 Update
IF NOT EXIST %SYS32%\Dism.exe ECHO Dism.exe is missing! && GOTO :Registry
%SYS32%\Dism.exe /Online /Disable-Feature /Featurename:Recall>NUL

:: REGISTRY ::
:Registry
Echo([^|^|^|   ]
@FOR /F "TOKENS=*" %%G IN ( regbad.cfg ) DO @REG QUERY "%%G" 2>NUL|GREP -Es "^HKEY_">>temp00
FOR /F "TOKENS=*" %%G IN ( temp00 ) DO @(
  ECHO.%%G>>"%TEMP%\004"
  REG DELETE "%%G" /F >NUL 2>&1
  )
DEL /F/Q temp0? >NUL 2>&1

REM ~~~~~ NON MALWARE ENTRIES ~~~~~~~\/
REG DELETE "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /VA /F >NUL 2>&1
REG DELETE "HKLM\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION" /V OneDrive.exe /F >NUL 2>&1
REG DELETE %URunOnce% /V OMENCC_InstallationBooster /F >NUL 2>&1
REG DELETE %URunOnce% /V OneDrive /F >NUL 2>&1
REG DELETE HKCR\.htm\OpenWithProgids /V MSEdgeHTM /F >NUL 2>&1
REG DELETE HKCR\.html\OpenWithProgids /V MSEdgeHTM /F >NUL 2>&1
REG DELETE HKCR\.mht\OpenWithProgids /V MSEdgeMHT /F >NUL 2>&1
REG DELETE HKCR\.pdf\OpenWithProgids /V MSEdgePDF /F >NUL 2>&1
REG DELETE HKCR\.shtml\OpenWithProgids /V MSEdgeHTM /F >NUL 2>&1
REG DELETE HKCU\Environment /V OneDrive /F >NUL 2>&1
REG DELETE HKCU\Environment /V OneDriveConsumer /F >NUL 2>&1
REG DELETE HKCU\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run /V OneDriveSetup /F >NUL 2>&1
REG DELETE HKLM\Software\Microsoft\Windows\CurrentVersion\Run /V HPOneAgentService /F >NUL 2>&1
REG DELETE HKLM\Software\Microsoft\Windows\CurrentVersion\Run /V TeamsMachineInstaller /F >NUL 2>&1
REG DELETE HKLM\Software\Microsoft\Windows\CurrentVersion\Run /V XboxStat /F >NUL 2>&1
REG DELETE HKLM\Software\RegisteredApplications /V "Microsoft Edge" /F >NUL 2>&1
REG DELETE HKU\S-1-5-19\Environment /V OneDrive /F >NUL 2>&1
REG DELETE HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\Run /V HPCC_InstallationBooster /F >NUL 2>&1
REG DELETE HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\Run /V HPSEU_Host_Launcher /F >NUL 2>&1
REG DELETE HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce /V OMENCC_InstallationBooster /F >NUL 2>&1
REG DELETE HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce /V OneDrive /F >NUL 2>&1
REG DELETE HKU\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\RunOnce /V OneDriveSetup /F >NUL 2>&1
REG DELETE HKU\S-1-5-20\Environment /V OneDrive /F >NUL 2>&1
REG DELETE HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\Run /V HPCC_InstallationBooster /F >NUL 2>&1
REG DELETE HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\Run /V HPSEU_Host_Launcher /F >NUL 2>&1
REG DELETE HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce /V OMENCC_InstallationBooster /F >NUL 2>&1
REG DELETE HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce /V OneDrive /F >NUL 2>&1
REG DELETE HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\RunOnce /V OneDriveSetup /F >NUL 2>&1
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
                           ECHO(%URUN%\\"%%G">>"%TEMP%\004"
                           REG DELETE %URUN% /V "%%G" /F >NUL 2>&1
                          )
)

:XboxHuer
REG QUERY HKCR 2>NUL|GREP -Eis "\\(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">"%TEMP%\privwindozelogh.txt"
REG QUERY "HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol" 2>NUL|GREP -Eis "\\(xboxliveapp-[0-9]{4,}|ms-xbl-[a-f0-9]{6,})$">>"%TEMP%\privwindozelogh.txt"
REG QUERY HKLM\SYSTEM\CurrentControlSet\Services\EventLog\Application 2>NUL|GREP -Eis "\\(Edge|edgeupdate.*|HPAnalytics|HPTouchpointAnalyticsService)$">>"%TEMP%\privwindozelogh.txt"
REG QUERY HKLM\Software\Microsoft\Tracing 2>NUL|GREP -Es "RAS[A-Z0-9]{5}$">>"%TEMP%\privwindozelogh.txt"
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelogh.txt") DO (
  ECHO."%%G">>"%TEMP%\004"
  REG DELETE "%%G" /F >NUL 2>&1
)

@FOR /F "TOKENS=*" %%G IN ( reglocs_pkgs.cfg ) DO @REG QUERY "%%G" 2>NUL>>temp00
REG QUERY "HKLM\SYSTEM\Setup\Upgrade\Appx\DownlevelGather\AppxAllUserStore\%SID%" 2>NUL>>temp00
REG QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\%SID%" 2>NUL>>temp00
GREP -Eis "Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MicrosoftPCManager|MixedReality|OneConnect|ScreenSketch|Services\.Store\.Engagement|Teams|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <temp00 >temp01
GREP -Eis "MicrosoftWindows\.(Client\.WebExperience|LKG\.DesktopSpotlight)|MicrosoftCorporationII\.(QuickAssist|WinAppRuntime|MicrosoftFamily)|LenovoCompanion|CortanaUI" <temp00 >>temp01
GREP -Eis "acerincorporated|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames" <temp00 >>temp01
SORT_ -f -u <temp01 >temp02
IF EXIST temp02 (
  FOR /F "TOKENS=*" %%G IN ( temp02 ) DO @(
    ECHO.%%G >>"%TEMP%\004"
    REG DELETE "%%G" /F >NUL 2>&1
    ) )
DEL /F/Q temp0? >NUL 2>&1

REG QUERY "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"|GREP -Es "    \{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}" >temp00
IF ERRORLEVEL 1 ( GOTO :FirewallOrphans )
GREP -Es "Name=Microsoft Edge|Name=@\{Microsoft\.(Bing|Todos|microsoftteams|Xbox|Zune)|Name=@\{(Clipchamp|AD2F1837)\." <temp00 >temp01
IF ERRORLEVEL 1 ( GOTO :FirewallOrphans )
SED -r "s/^\s+(\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}).*/\1/" <temp01 >temp02
IF EXIST temp02 (
  FOR /F "TOKENS=*" %%G IN ( temp02 ) DO @REG DELETE HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules /V "%%G" /F >NUL 2>&1
  )

:FirewallOrphans

DEL /F/Q temp0? >NUL 2>&1
:EdgeAutoLaunch
REG QUERY "%URun%" 2>NUL|GREP -Eis "MicrosoftEdgeAutoLaunch_[A-F0-9]{32}">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :SubscribedContent )
SED -r "s/^\s{4}(MicrosoftEdgeAutoLaunch_[A-F0-9]{32})\s+REG_SZ\s+.*/\1/" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /F %%G in (%TEMP%\privwindozelogr2.txt) DO (
    ECHO(%URun%\\%%G>>"%TEMP%\004"
    REG DELETE "%URun%" /V "%%G" /F >NUL 2>&1
)

:SubscribedContent
REG QUERY %CUCDM% 2>NUL|GREP -Eis "SubscribedContent-[0-9]{5,}Enabled">"%TEMP%\privwindozelogr.txt"
IF ERRORLEVEL 1 ( GOTO :Policies )
SED -r "s/^\s{4}(SubscribedContent-[0-9]{5,}Enabled)\s+REG_DWORD\s+.*/\1/" <"%TEMP%\privwindozelogr.txt" >"%TEMP%\privwindozelogr2.txt"
FOR /F %%G in (%TEMP%\privwindozelogr2.txt) DO (
    ECHO(%CUCDM%\\%%G>>"%TEMP%\004"
    REG DELETE %CUCDM% /V "%%G" /F >NUL 2>&1
)

:: POLICIES ::
:Policies
REM Legacy Context Menu
REG ADD HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve >NUL 2>&1

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

REG ADD "HKCU\Software\Policies\Microsoft\Windows\Windows Feeds" /T REG_DWORD /V EnableFeeds /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /T REG_DWORD /V DontSendAdditionalData /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /T REG_DWORD /V AllowSearchToUseLocation /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /T REG_DWORD /V ConnectedSearchPrivacy /D 3 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /T REG_DWORD /V ConnectedSearchUseWeb /D 0 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /T REG_DWORD /V DisableWebSearch /D 1 /F >NUL 2>&1
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /T REG_DWORD /V PreventRemoteQueries /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo /T REG_DWORD /V Enabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack /T REG_DWORD /V ShowedToastAtLevel /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V AlwaysShowMenus /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V DisablePreviewDesktop /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V EnableSnapAssistFlyout /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V ShowCopilotButton /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V ShowCortanaButton /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V ShowInfoTip /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V ShowSyncProviderNotifications /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V Start_IrisRecommendations /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V Start_ShowClassicMode /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V TaskbarAl /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V TaskbarAutoHideInTabletMode /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V TaskbarDa /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V TaskbarMn /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /T REG_DWORD /V TaskbarSi /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /T REG_DWORD /V HideSCAMeetNow /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy /T REG_DWORD /V TailoredExperiencesWithDiagnosticDataEnabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications /T REG_DWORD /V ToastEnabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Search /T REG_DWORD /V BingSearchEnabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Search /T REG_DWORD /V CortanaConsent /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Search /T REG_DWORD /V SearchboxTaskbarMode /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Search /T REG_DWORD /V SearchboxTaskbarModeCache /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /T REG_DWORD /V IsAADCloudSearchEnabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /T REG_DWORD /V IsDeviceSearchHistoryEnabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /T REG_DWORD /V IsDynamicSearchBoxEnabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /T REG_DWORD /V SafeSearchMode /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement /T REG_DWORD /V ScoobeSystemSettingEnabled /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\WindowsCopilot /T REG_DWORD /V AllowCopilotRuntime /D 0 /F >NUL 2>&1
REG ADD HKCU\Software\Policies\Microsoft\Windows\EdgeUI /T REG_DWORD /V DisableMFUTracking /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Policies\Microsoft\Windows\WindowsAI /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1
REG ADD HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot /T REG_DWORD /V TurnOffWindowsCopilot /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\FileExplorer\AllowOptionToShowNetwork /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\FileExplorer\AllowOptionToShowThisPC /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\FileExplorer\DisableGraphRecentItems /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\FileExplorer\SetAllowedFolderLocations /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\FileExplorer\SetAllowedStorageLocations /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\power\TurnOffHybridSleepOnBattery /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\power\TurnOffHybridSleepPluggedIn /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\power\UnattendedSleepTimeoutOnBattery /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\power\UnattendedSleepTimeoutPluggedIn /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\DisableAdvertisingId /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\DisablePrivacyExperience /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\EnableActivityFeed /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessAccountInfo /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessBackgroundSpatialPerception /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessCalendar /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessCallHistory /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessCamera /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessContacts /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessEmail /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessGazeInput /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessGraphicsCaptureProgrammatic /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessGraphicsCaptureWithoutBorder /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessHumanPresence /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessLocation /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessMessaging /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessMicrophone /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessMotion /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessNotifications /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessPhone /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessRadios /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsAccessTasks /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\LetAppsSyncWithDevices /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\PublishUserActivities /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\privacy\UploadUserActivities /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowCloudSearch /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowCortanaInAAD /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowFindMyFiles /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowIndexingEncryptedStoresOrItems /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowSearchHighlights /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowSearchToUseLocation /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowStoringImagesFromVisionSearch /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowUsingDiacritics /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AllowWindowsIndexer /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\AlwaysUseAutoLangDetection /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\ConfigureSearchOnTaskbarMode /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\DisableBackoff /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\DisableRemovableDriveIndexing /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\DisableSearch /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\DoNotUseWebResults /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\PreventIndexingLowDiskSpaceMB /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\PreventRemoteQueries /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\search\SafeSearchPermissions /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\smartscreen\EnableAppInstallControl /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\smartscreen\EnableSmartScreenInShell /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\smartscreen\PreventOverrideForFilesInShell /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\speakforme\EnableSpeakForMe /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\System\AllowTelemetry /T REG_DWORD /V value /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Microsoft\PolicyManager\default\WindowsAI\TurnOffWindowsCopilot /T REG_DWORD /V value /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo /T REG_DWORD /V DisabledByGroupPolicy /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Policies\Microsoft\Windows\CloudContent /T REG_DWORD /V DisableWindowsConsumerFeatures /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Policies\Microsoft\Windows\DataCollection /T REG_DWORD /V AllowTelemetry /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Policies\Microsoft\Windows\DataCollection /T REG_DWORD /V MaxTelemetryAllowed /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Policies\Microsoft\Windows\EdgeUI /T REG_DWORD /V DisableMFUTracking /D 1 /F >NUL 2>&1
REG ADD HKLM\Software\Policies\Microsoft\Windows\GameDVR /T REG_DWORD /V AllowGameDVR /D 0 /F >NUL 2>&1
REG ADD HKLM\Software\Policies\Microsoft\Windows\WindowsAI /T REG_DWORD /V DisableAIDataAnalysis /D 1 /F >NUL 2>&1


:: TASKS ::
Echo([^|^|^|^|  ]
FOR %%G in (
"Hewlett-Packard\HP Support Assistant\HP Support Assistant Update Notice"
"Hewlett-Packard\HP Support Assistant\HP Support Solutions Framework Report"
"Hewlett-Packard\HP Support Assistant\WarrantyChecker"
"Hewlett-Packard\HP Support Assistant\WarrantyChecker_DeviceScan"
"HP\Consent Manager Launcher"
"HPAudioSwitch"
"HPOneAgentRepairTask"
"Intel\Intel Telemetry 3"
"Lenovo\ImController\Lenovo iM Controller Monitor"
"Lenovo\ImController\Lenovo iM Controller Scheduled Maintenance"
"Lenovo\ImController\Plugins\LenovoSystemUpdatePlugin_WeeklyTask"
"Lenovo\Lenovo Service Bridge\%SID%"
"Lenovo\LenovoNowLauncher"
"Lenovo\LenovoNowQuarterlyLaunch"
"Lenovo\LenovoNowTask"
"Lenovo\LenovoNowTaskRemindMeLater"
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
"Lenovo\Vantage\Schedule\NightChargeToastEvent"
"Lenovo\Vantage\Schedule\NotificationCenter"
"Lenovo\Vantage\Schedule\SettingsWidgetAddinDailyScheduleTask"
"Lenovo\Vantage\Schedule\SmartPerformance.ExpireReminder"
"Lenovo\Vantage\Schedule\VantageCoreAddinIdleScheduleTask"
"Lenovo\Vantage\Schedule\VantageCoreAddinWeekScheduleTask"
"Lenovo\Vantage\StartupFixPlan"
"McAfeeTsk\OOBEUpgrader"
"Microsoft\Office\Office 15 Subscription Heartbeat"
"Microsoft\Office\Office Performance Monitor"
"Microsoft\Office\OfficeTelemetryAgentFallBack"
"Microsoft\Office\OfficeTelemetryAgentFallBack2016"
"Microsoft\Office\OfficeTelemetryAgentLogOn"
"Microsoft\Office\OfficeTelemetryAgentLogOn2016"
"Microsoft\Windows\AppID\VerifiedCert"
"Microsoft\Windows\Application Experience\MareBackup"
"Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
"Microsoft\Windows\Application Experience\PcaPatchDbTask"
"Microsoft\Windows\Application Experience\PcaWallpaperAppDetect"
"Microsoft\Windows\Application Experience\SdbinstMergeDbTask"
"Microsoft\Windows\Application Experience\StartupAppTask"
"Microsoft\Windows\ApplicationData\appuriverifierdaily"
"Microsoft\Windows\ApplicationData\appuriverifierinstall"
"Microsoft\Windows\ApplicationData\DsSvcCleanup"
"Microsoft\Windows\capabilityaccessmanager\maintenancetasks"
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
"Microsoft\Windows\MasterDataG\RecoveryHosts"
"Microsoft\Windows\MasterDataG\RecoveryTask"
"Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
"Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
"Microsoft\Windows\NetService\Network\NetServices"
"Microsoft\Windows\PLA\New Data Collector Set"
"Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
"Microsoft\Windows\PushToInstall\LoginCheck"
"Microsoft\Windows\PushToInstall\Registration"
"Microsoft\Windows\RecoveryManagerS\RecoveryHosts"
"Microsoft\Windows\RecoveryManagerS\RecoveryTask"
"Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
"Microsoft\Windows\Services\CertPathCheck"
"Microsoft\Windows\WindowsAI\Recall\InitialConfiguration"
"Microsoft\Windows\WindowsAI\Recall\PolicyConfiguration"
"Microsoft\Windows\Services\CertPathw"
"Microsoft\Windows\Servicing\ComponentCleanup"
"Microsoft\Windows\Servicing\OOBEFodSetup"
"Microsoft\Windows\Servicing\ServiceCleanup"
"Microsoft\Windows\Shell\CreateObjectTask"
"Microsoft\Windows\Shell\FamilySafetyMonitor"
"Microsoft\Windows\Shell\FamilySafetyRefreshTask"
"Microsoft\Windows\Shell\IndexerAutomaticMaintenance"
"Microsoft\Windows\Shell\ObjectTask"
"Microsoft\Windows\Shell\ThemesSyncedImageDownload"
"Microsoft\Windows\Sustainability\SustainabilityTelemetry"
"Microsoft\Windows\UpdateOrchestrator\USO_UxBroker"
"Microsoft\Windows\User Profile Service\HiveUploadTask"
"Microsoft\Windows\WlanSvc\CDSSync"
"Microsoft\Windows\WOF\WIM-Hash-Management"
"Microsoft\Windows\WOF\WIM-Hash-Validation"
"Microsoft\Windows\WwanSvc\NotificationTask"
"Microsoft\Windows\WwanSvc\OobeDiscovery"
"Microsoft\XblGameSave\XblGameSaveTask"
"MicrosoftEdgeUpdateBrowserReplacementTask"
"MSI_GamebarConnect"
"MSI_GamebarTool"
"Samsung_PSSD_Registration_Plus"
"TVT\TVSUUpdateTask"
"TVT\TVSUUpdateTask_UserLogOn"
"UbtFrameworkService"
"UEIPInvitation"
) DO @(
  IF EXIST "%STASKS%\%%G" (
    ECHO..\"%%G">>"%TEMP%\002"
    SCHTASKS /DELETE /TN %%G /F >NUL 2>&1
    )
)

DIR /B/A:-D "%STASKS%" 2>NUL|GREP -Eis "^(MicrosoftEdgeUpdateTask|OneDrive|Omen(Install|Overlay)|NvTmRep_|Asus|SystemOptimizer)|Telemetry">temp00
SORT_ -f -u <temp00 >temp01
@FOR /F "TOKENS=*" %%G IN ( temp01 ) DO @(
  ECHO..\"%%G">>"%TEMP%\002"
  SCHTASKS /DELETE /TN "%%G" /F >NUL 2>&1
  )
)

DIR /B/A:-D "%STASKS%\Lenovo\ImController\TimeBasedEvents" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">temp00
SORT_ -f -u <temp00 >temp01
@FOR /F "TOKENS=*" %%G IN ( temp01 ) DO @(
  ECHO..\Lenovo\ImController\TimeBasedEvents\"%%G">>"%TEMP%\002"
  SCHTASKS /DELETE /TN "Lenovo\ImController\TimeBasedEvents\%%G" /F >NUL 2>&1
  )
)

DIR /B/A:-D "%STASKS%\Lenovo\UDC\MessagingPlugin" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">temp00
SORT_ -f -u <temp00 >temp01
@FOR /F "TOKENS=*" %%G IN ( temp01 ) DO @(
  ECHO..\Lenovo\UDC\MessagingPlugin\"%%G">>"%TEMP%\002"
  SCHTASKS /DELETE /TN "Lenovo\UDC\MessagingPlugin\%%G" /F >NUL 2>&1
  )
)

DIR /B/A:-D "%STASKS%\Lenovo\UDC\SystemNotificationPlugin" 2>NUL|GREP -Eis "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$">temp00
SORT_ -f -u <temp00 >temp01
@FOR /F "TOKENS=*" %%G IN ( temp01 ) DO @(
  ECHO..\Lenovo\UDC\SystemNotificationPlugin\"%%G">>"%TEMP%\002"
  SCHTASKS /DELETE /TN "Lenovo\UDC\SystemNotificationPlugin\%%G" /F >NUL 2>&1
  )
)

:Services
Echo([^|^|^|^|^| ]
@FOR /F "TOKENS=*" %%G IN ( svc_stop_disable.cfg ) DO @(
  SC CONFIG "%%G" start= disabled|GREP -Es "ChangeServiceConfig SUCCESS">temp00
  IF NOT ERRORLEVEL 1 (
    ECHO.%%G ^(%Log_SVCDisabled%^)>>"%TEMP%\000b"
    )
)

@FOR /F "TOKENS=*" %%G IN ( svc_stop_disable.cfg ) DO @(
  SC STOP "%%G"|GREP -Es "STOP_PENDING|ControlService FAILED 1062">temp00
  IF NOT ERRORLEVEL 1 (
    ECHO.%%G ^(%Log_SVCStopped%^)>>"%TEMP%\000b"
    )
)

@FOR /F "TOKENS=*" %%G IN ( svc_delete.cfg ) DO @(
  SC QUERY "%%G"|GREP -Es "WAIT_HINT">temp00
  IF NOT ERRORLEVEL 1 (
    ECHO.%%G ^(%Log_SVCDeleted%^)>>"%TEMP%\000b"
    SC DELETE "%%G">nul
    REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\%%G" /F >NUL 2>&1
    )
)
DEL /A/F temp0? >NUL 2>&1
:EdgeService
REG QUERY "HKLM\SYSTEM\CurrentControlSet\services" 2>NUL>"%TEMP%\privwindozesvc.txt"
SED -r "s/^HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\//" <"%TEMP%\privwindozesvc.txt" >"%TEMP%\privwindozesvc2.txt"
GREP -Eis "^edgeupdate.*" <"%TEMP%\privwindozesvc2.txt" >"%TEMP%\privwindozesvc2_found.txt"
IF ERRORLEVEL 1 ( GOTO :DiscordFiles )
SORT_ -f -u <"%TEMP%\privwindozesvc2_found.txt" >"%TEMP%\privwindozesvc2_del.txt"
@FOR /F "TOKENS=*" %%G IN ( %TEMP%\privwindozesvc2_del.txt ) DO @(
  SC CONFIG "%%G" start= disabled|GREP -Es "ChangeServiceConfig SUCCESS">temp00
  IF NOT ERRORLEVEL 1 (
    ECHO.%%G ^(%Log_SVCDisabled%^)>>"%TEMP%\000b"
    )
)

@FOR /F "TOKENS=*" %%G IN ( %TEMP%\privwindozesvc2_del.txt ) DO @(
  SC STOP "%%G"|GREP -Es "STOP_PENDING|ControlService FAILED 1062">temp00
  IF NOT ERRORLEVEL 1 (
    ECHO.%%G ^(%Log_SVCStopped%^)>>"%TEMP%\000b"
    )
)

@FOR /F "TOKENS=*" %%G IN ( %TEMP%\privwindozesvc2_del.txt ) DO @(
  SC QUERY "%%G"|GREP -Es "WAIT_HINT">temp00
  IF NOT ERRORLEVEL 1 (
    ECHO.%%G ^(%Log_SVCDeleted%^)>>"%TEMP%\000b"
    SC DELETE "%%G">nul
    REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\%%G" /F >NUL 2>&1
    )
)

:DiscordFiles
ECHO.[^|^|^|^|^|^|]
IF EXIST "%APPDATA%\discord\Code Cache\js" DIR /B/S/A:-D "%APPDATA%\discord\Code Cache\js" 2>NUL>appdata00
IF EXIST "%APPDATA%\discord\Code Cache\js" (
GREP -Esi "\\js\\([a-f0-9]{16,}_0|index)$" <appdata00 >appdata01
SORT_ -f -u <appdata01 >appdata02
FOR /F "TOKENS=*" %%G IN ( appdata02 ) DO @(
  ECHO.%%G>>"%TEMP%\001"
  DEL /F/Q "%%G" >NUL 2>&1
  )
)
:Discord2
IF EXIST "%APPDATA%\discord\Cache\Cache_Data" DIR /B/S/A:-D "%APPDATA%\discord\Cache\Cache_Data" 2>NUL>appdata00
IF EXIST "%APPDATA%\discord\Cache\Cache_Data" (
GREP -Esi "\\Cache_Data\\(f_[a-f0-9]{6,}|data_[0-9]|index)$" <appdata00 >appdata01
SORT_ -f -u <appdata01 >appdata02
FOR /F "TOKENS=*" %%G IN ( appdata02 ) DO @(
  ECHO.%%G>>"%TEMP%\001"
  DEL /F/Q "%%G" >NUL 2>&1
  )
)
:InboxApps
IF EXIST "%WINDIR%\InboxApps" DIR /B/S/A:-D "%WINDIR%\InboxApps" 2>NUL>windir00
IF EXIST "%WINDIR%\InboxApps" (
GREP -Esi "\\Microsoft\.(Bing|Copilot|StartExperiencesApp)" <windir00 >windir01
SORT_ -f -u <windir01 >windir02
FOR /F "TOKENS=*" %%G IN ( windir02 ) DO @(
  ECHO.%%G>>"%TEMP%\001"
  DEL /F/Q "%%G" >NUL 2>&1
  )
)
:D3DSCache
IF EXIST "%LOCALA%\D3DSCache" DIR /B/S/A:D "%LOCALA%\D3DSCache" 2>NUL>locala00
IF EXIST "%LOCALA%\D3DSCache" (
GREP -Esi "\\[a-f0-9]{10,}$" <locala00 >locala01
SORT_ -f -u <locala01 >locala02
FOR /F "TOKENS=*" %%G IN ( locala02 ) DO @(
  ECHO.%%G>>"%TEMP%\001b"
  RD /S/Q "%%G" >NUL 2>&1
  )
)
:D3DSCache2
IF EXIST "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache" DIR /B/S/A:D "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache" 2>NUL>sys32appdata00
IF EXIST "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\D3DSCache" (
GREP -Esi "\\[a-f0-9]{10,}$" <sys32appdata00 >sys32appdata01
SORT_ -f -u <sys32appdata01 >sys32appdata02
FOR /F "TOKENS=*" %%G IN ( sys32appdata02 ) DO @(
  ECHO.%%G>>"%TEMP%\001b"
  RD /S/Q "%%G" >NUL 2>&1
  )
)
:D3DSCache3
IF EXIST "%SYS32%\config\systemprofile\AppData\Local\D3DSCache" DIR /B/S/A:D "%SYS32%\config\systemprofile\AppData\Local\D3DSCache" 2>NUL>sys32appdata00
IF EXIST "%SYS32%\config\systemprofile\AppData\Local\D3DSCache" (
GREP -Esi "\\[a-f0-9]{10,}$" <sys32appdata00 >sys32appdata01
SORT_ -f -u <sys32appdata01 >sys32appdata02
FOR /F "TOKENS=*" %%G IN ( sys32appdata02 ) DO @(
  ECHO.%%G>>"%TEMP%\001b"
  RD /S/Q "%%G" >NUL 2>&1
  )
)
:Twtmp
IF EXIST "%SYS32%\config\systemprofile\AppData\Local" DIR /B/S/A:D "%SYS32%\config\systemprofile\AppData\Local" 2>NUL>sys32appdata00
IF EXIST "%SYS32%\config\systemprofile\AppData\Local" (
GREP -Esi "\\tw-[a-f0-9]{2,}-[a-f0-9]{2,}-[a-f0-9]{2,}\.tmp$" <sys32appdata00 >sys32appdata01
SORT_ -f -u <sys32appdata01 >sys32appdata02
FOR /F "TOKENS=*" %%G IN ( sys32appdata02 ) DO @(
  ECHO.%%G>>"%TEMP%\001b"
  RD /S/Q "%%G" >NUL 2>&1
  )
)
:JavaCache
IF EXIST "%LOCALLOW%\Sun\Java\Deployment\cache" DIR /B/S/A:-D "%LOCALLOW%\Sun\Java\Deployment\cache" 2>NUL>locallow00
IF EXIST "%LOCALLOW%\Sun\Java\Deployment\cache" (
GREP -Esi "\\cache\\[0-9]\.[0-9]\\[0-9]{2,}\\[a-f0-9]{8,}-[a-f0-9]{8,}$" <locallow00 >locallow01
SORT_ -f -u <locallow01 >locallow02
FOR /F "TOKENS=*" %%G IN ( locallow02 ) DO @(
  ECHO.%%G>>"%TEMP%\001"
  DEL /F/Q "%%G" >NUL 2>&1
  )
)
:SteamCache
IF EXIST "%LOCALA%\Steam\htmlcache" DIR /B/S/A:-D "%LOCALA%\Steam\htmlcache" 2>NUL>locala00
IF EXIST "%LOCALA%\Steam\htmlcache" (
GREP -Esi "\\htmlcache\\(ChromeDWriteFontCache|data_[0-9]|index|Visited Links)$" <locala00 >locala01
SORT_ -f -u <locala01 >locala02
FOR /F "TOKENS=*" %%G IN ( locala02 ) DO @(
  ECHO.%%G>>"%TEMP%\001"
  DEL /F/Q "%%G" >NUL 2>&1
  )
)
:INetCache
IF EXIST "%LOCALA%\Microsoft\Windows\INetCache\IE" DIR /B/S/A:D "%LOCALA%\Microsoft\Windows\INetCache\IE" 2>NUL>locala00
IF EXIST "%LOCALA%\Microsoft\Windows\INetCache\IE" (
GREP -Es "\\[A-Z0-9]{8}$" <locala00 >locala01
SORT_ -f -u <locala01 >locala02
FOR /F "TOKENS=*" %%G IN ( locala02 ) DO @(
  ECHO.%%G>>"%TEMP%\001b"
  RD /S/Q "%%G" >NUL 2>&1
  )
)
:Localpackages
DIR /B/A:D "%LOCALA%\Packages" 2>NUL>"%TEMP%\privwindozelogp.txt"
IF ERRORLEVEL 1 ( GOTO :Blizzard )
GREP -Eis "^Microsoft\.(549981C3F5F10|Advertising|Bing|Client\.WebExperience|Copilot|DiagnosticDataViewer|Edge|Gaming|Microsoft3DViewer|MicrosoftEdge|MicrosoftOfficeHub|MicrosoftPCManager|MixedReality|OneConnect|People|ScreenSketch|Services\.Store\.Engagement|Teams|Todos|WidgetsPlatformRuntime|WindowsAlarms|WindowsFeedbackHub|Windows\.Ai\.Copilot|Xbox|YourPhone|Zune)" <"%TEMP%\privwindozelogp.txt" >"%TEMP%\privwindozelogp_found.txt"
GREP -Eis "^MicrosoftWindows\.(Client\.WebExperience|LKG\.DesktopSpotlight)|^MicrosoftCorporationII\.(QuickAssist|WinAppRuntime|MicrosoftFamily)|LenovoCompanion|CortanaUI" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp_found.txt"
GREP -Eis "^(acerincorporated\.|9426MICRO-STAR|AD2F1837|B9ECED6F|Clipchamp|DellInc\.|E046963F|MicrosoftTeams|MSTeams|TobiiAB\.TobiiEyeTrackingPortal|WildTangentGames)" <"%TEMP%\privwindozelogp.txt" >>"%TEMP%\privwindozelogp_found.txt"
SORT_ -f -u <"%TEMP%\privwindozelogp_found.txt" >"%TEMP%\privwindozelogp_del.txt"
FOR /F "usebackq delims=" %%G in ("%TEMP%\privwindozelogp_del.txt") DO (
    SET "packages=%%G"
    SETLOCAL EnableDelayedExpansion
    IF EXIST "!LOCALA!\Packages\!packages!" (
                                              ECHO("!LOCALA!\Packages\!packages!">>"%TEMP%\001b"
                                              RD /S/Q "!LOCALA!\Packages\!packages!" >NUL 2>&1
                                              )
    ENDLOCAL
)
:Blizzard
DIR /B/A:-D "%LOCALA%\Blizzard Entertainment\Telemetry" 2>NUL|GREP -Es ".*">temp00
IF ERRORLEVEL 1 ( GOTO :Firefox )
@FOR /F "TOKENS=*" %%G IN ( temp00 ) DO @(
  ECHO."%LOCALA%\Blizzard Entertainment\Telemetry\%%G">>"%TEMP%\001"
  DEL /F/Q "%LOCALA%\Blizzard Entertainment\Telemetry\%%G" >NUL 2>&1
  )
:Firefox
IF NOT EXIST "%APPDATA%\Mozilla\Firefox\Profiles" GOTO :Rootkits
DIR /B/A:D "%APPDATA%\Mozilla\Firefox\Profiles\%FFPROFILE%\storage\to-be-removed" 2>NUL|GREP -Eis "\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}">"%TEMP%\privwindozeff00.txt"
IF ERRORLEVEL 1 ( GOTO :Rootkits )
FOR /F "TOKENS=*" %%G IN ( %TEMP%\privwindozeff00.txt ) DO @(
  ECHO."%APPDATA%\Mozilla\Firefox\Profiles\%FFPROFILE%\storage\to-be-removed\%%G">>"%TEMP%\001b"
  RD /S/Q "%APPDATA%\Mozilla\Firefox\Profiles\%FFPROFILE%\storage\to-be-removed\%%G" >NUL 2>&1
  )
:Rootkits
IF NOT EXIST %SYS32%\pnputil.exe ECHO pnputil.exe is missing! && GOTO :Files
%SYS32%\pnputil.exe /enum-drivers 2>NUL|GREP -Es "^Original Name">"%TEMP%\privwindozelogrk.txt"
IF ERRORLEVEL 1 ( GOTO :Files )
SED -r "s/^Original Name.\s{4,}//" <"%TEMP%\privwindozelogrk.txt" >"%TEMP%\privwindozelogrk2.txt"
SORT_ -f -u <"%TEMP%\privwindozelogrk2.txt" >"%TEMP%\privwindozelogrk3.txt"
GREP -Eis "^(hp(analytics|(omen)?customcap)comp\.inf|lenovoyx[x|8]0\.inf|hpspsnotification\.inf)$" <"%TEMP%\privwindozelogrk3.txt" >"%TEMP%\privwindozelogrk4.txt"
IF ERRORLEVEL 1 ( GOTO :Drivers2 )
:: NIRCMD BEEP 1400 50
FOR /F %%G in (%TEMP%\privwindozelogrk4.txt) DO (
    Echo(%%G>>"%TEMP%\000"
    %SYS32%\pnputil.exe /delete-driver %%G /uninstall /force >NUL 2>&1
)

:Drivers2
DIR /B/S/A:-D "%SYS32%\DriverStore\FileRepository" 2>NUL|GREP -Eis "\\(hp|lenovoyx)">drivers00
IF ERRORLEVEL 1 ( GOTO :Files )
GREP -Esi "\\hpanalyticscomp.inf_.*\\TouchpointAnalyticsClientService\.exe$" <drivers00 >drivers01
GREP -Esi "\\hpcustomcapcomp\.inf_.*\\x[64|86]\\(DiagsCap|AppHelperCap|NetworkCap|SysInfoCap)\.exe$" <drivers00 >>drivers01
GREP -Esi "\\hpcustomcapdriver.inf_.*\\x[64|86]\\hpcustomcapdriver\.sys$" <drivers00 >>drivers01
GREP -Esi "\\hpspsnotification\.inf_.*\\HpSpsNotification\.sys$" <drivers00 >>drivers01
GREP -Esi "\\lenovoyx[x|8]0\.inf_.*\\platform_runtime_(ALENOVOYX80|RGB)_service\.exe$" <drivers00 >>drivers01
SORT_ -f -u <drivers01 >drivers02
IF ERRORLEVEL 1 ( GOTO :Files )
DEL /F/Q drivers00 drivers01 >NUL 2>&1
FOR /F "TOKENS=*" %%G IN ( drivers02 ) DO @(
  ECHO.%%G>>"%TEMP%\000"
  DEL /F/Q "%%G" >NUL 2>&1
  IF EXIST "%%G" (
    ICACLS "%%G" /RESET /Q >NUL 2>&1
    DEL /F/Q "%%G" >NUL 2>&1
    )
)

DEL /F/Q drivers0? >NUL 2>&1

:Files
FOR %%G in (
"%ALLUSERSPROFILE%\Microsoft\Windows\OneSettings\CortanaUWP.json"
"%ALLUSERSPROFILE%\Package Cache\{A59BC4A0-0F57-4F97-95E4-641AB5C3A9B0}\HPOneAgent.exe"
"%APPDATA%\Slate Digital Connect\SDACollector\sdaCollector.vbs"
"%LOCALA%\Microsoft\BingWallpaperApp\BingWallpaperApp.exe"
"%PROGFILES32%\Dell\DellDataVault\DDVCollectorSvcApi.exe"
"%PROGFILES32%\Dell\DellDataVault\DDVDataCollector.exe"
"%PROGFILES32%\Dell\DTP\AnalyticsSubAgent\Dell.TechHub.Analytics.SubAgent.exe"
"%PROGFILES32%\HP\HP Enabling Services\AppHelperCap.exe"
"%PROGFILES32%\HP\HP Enabling Services\DiagsCap.exe"
"%PROGFILES32%\HP\HP Enabling Services\NetworkCap.exe"
"%PROGFILES32%\HP\HP Enabling Services\SysInfoCap.exe"
"%PROGFILES32%\HP\HP Touchpoint Analytics Client\TouchpointAnalyticsClientService.exe"
"%PROGFILES32%\HPCommRecovery\HPCommRecovery.exe"
"%PROGRAMSAUP%\Microsoft Edge Beta.lnk"
"%PROGRAMSAUP%\Microsoft Edge.lnk"
"%PROGRAMSAUP%\OneDrive.lnk"
"%PROGRAMSCU%\Microsoft Corporation\Microsoft Teams.lnk"
"%PROGRAMSCU%\Microsoft Edge.lnk"
"%PROGRAMSCU%\OneDrive.lnk"
"%PUBDESKTOP%\Microsoft Edge.lnk"
"%QUICKLAUNCH%\Microsoft Edge.lnk"
"%QUICKLAUNCHTB%\Microsoft Edge.lnk"
"%STARTMENUAUP%\Adobe offers.lnk"
"%SYS32%\drivers\Intel\ICPS\IntelAnalyticsService.exe"
"%SYS32%\drivers\Lenovo\udc\Service\UDClientService.exe"
"%SYSTEMDRIVE%\System.sav\util\HPCC\HpccLauncher.exe"
"%SYSTEMDRIVE%\System.sav\util\HPSEU\HpseuHostLauncher.exe"
"%SYSTEMDRIVE%\system.sav\util\OMENCC_InstallationBooster.exe"
"%SYSTEMDRIVE%\system.sav\util\TDC\MCPP\UnitData\Subs\datacollect.exe"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\Desktop\Microsoft Teams.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%USERPROFILE%\OneDrive\Desktop\Microsoft Edge.lnk"
"%USERPROFILE%\OneDrive\Desktop\Microsoft Teams.lnk"
) DO @(
  IF EXIST "%%G" (
    ECHO."%%G">>"%TEMP%\001"
    DEL /F/Q %%G >NUL 2>&1
    IF EXIST "%%G" (
      ICACLS %%G /RESET /Q >NUL 2>&1
      DEL /F/Q %%G >NUL 2>&1
      )
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
) DO @DEL /F/Q "%%G" >NUL 2>&1

FOR %%G in (
"%ALLUSERSPROFILE%\Intel Telemetry"
"%ALLUSERSPROFILE%\Microsoft OneDrive"
"%ALLUSERSPROFILE%\Microsoft\EdgeUpdate"
"%APPDATA%\Microsoft\Teams"
"%LOCALA%\Blizzard Entertainment\Telemetry"
"%LOCALA%\GameAnalytics"
"%LOCALA%\Microsoft\BGAHelperLib"
"%LOCALA%\Microsoft\BingWallpaperApp"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\EdgeUpdate"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\Teams"
"%LOCALA%\Microsoft\TeamsMeetingAdd-in"
"%LOCALA%\Microsoft\TeamsMeetingAddin"
"%LOCALA%\Microsoft\TeamsPresenceAddin"
"%LOCALA%\Microsoft\XboxLive"
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\OneDrive"
"%PROGFILES32%\Acer\User Experience Improvement Program Service"
"%PROGFILES32%\Dell\DTP\AnalyticsSubAgent"
"%PROGFILES32%\HP\HP Enabling Services"
"%PROGFILES32%\HP\HP One Agent"
"%PROGFILES32%\HP\OmenInstallMonitor"
"%PROGFILES32%\HP\SystemOptimizer"
"%PROGFILES32%\HPCommRecovery"
"%PROGFILES32%\Intel\Telemetry 3.0"
"%PROGFILES32%\Microsoft OneDrive"
"%PROGFILES32%\Microsoft\EdgeUpdater"
"%PROGFILES32%\Tobii\Tobii EyeX"
"%STASKS%\Microsoft\XblGameSave"
"%SYS32%\Microsoft-Edge-WebView"
"%USERPROFILE%\MicrosoftEdgeBackups"
"%WINDIR%\DiagTrack"
"%WINDIR%\GameBarPresenceWriter"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\GameDVR"
"%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\GameExplorer"
"%WINDIR%\ServiceProfiles\LocalService\OneDrive"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\GameDVR"
"%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\GameExplorer"
"%WINDIR%\ServiceProfiles\NetworkService\OneDrive"
) DO @(
  IF EXIST %%G (
    ECHO.%%G>>"%TEMP%\001b"
    RD /S/Q %%G >NUL 2>&1
    IF EXIST %%G (
      ICACLS %%G /RESET /Q /T >NUL 2>&1
      RD /S/Q %%G >NUL 2>&1
      )
    )
)

IF EXIST "%PROGFILES64%" (
FOR %%G in (
"%PROGFILES64%\HP\HP Support Framework\Resources\BingPopup\BingPopup.exe"
"%PROGFILES64%\HP\HP System Event\HPWMISVC.exe"
) DO @(
  IF EXIST %%G (
    ECHO.%%G>>"%TEMP%\001"
    DEL /F/Q %%G >NUL 2>&1
    IF EXIST %%G (
      ICACLS %%G /RESET /Q >NUL 2>&1
      DEL /F/Q %%G >NUL 2>&1
      )
   )
  )
)

IF EXIST "%PROGFILES64%" (
FOR %%G in (
"%PROGFILES64%\HP\HP Support Framework\Resources\BingPopup"
"%PROGFILES64%\Lenovo\LenovoNow"
"%PROGFILES64%\Lenovo\VantageService"
"%PROGFILES64%\Microsoft\Edge Beta"
"%PROGFILES64%\Microsoft\Edge Dev"
"%PROGFILES64%\Microsoft\Edge"
"%PROGFILES64%\Microsoft\EdgeCore"
"%PROGFILES64%\Microsoft\EdgeUpdate"
"%PROGFILES64%\Microsoft\EdgeWebView"
"%PROGFILES64%\Microsoft\Temp"
"%PROGFILES64%\Teams Installer"
) DO @(
  IF EXIST %%G (
    ECHO.%%G>>"%TEMP%\001b"
    RD /S/Q %%G >NUL 2>&1
    IF EXIST %%G (
      ICACLS %%G /RESET /Q /T >NUL 2>&1
      RD /S/Q %%G >NUL 2>&1
      )
    )
  )
)

DIR /B/S/A:-D "%QUICKLAUNCH%" 2>NUL>quicklaunch00
GREP -Esi "\\(Microsoft Edge|OneDrive)\.lnk$" <quicklaunch00 >quicklaunch01
SORT_ -f -u <quicklaunch01 >quicklaunch02
FOR /F "TOKENS=*" %%G IN ( quicklaunch02 ) DO @(
  ECHO.%%G>>"%TEMP%\001"
  DEL /F/Q "%%G" >NUL 2>&1
)

:BitsTransfer
REM Edge may still show up in this list so we are removing any of these jobs that currently contain an error. We do this because we just removed Edge.
POWERSHELL -command "Get-BitsTransfer -AllUsers | Where-Object { $_.JobState -CContains 'Error' } | Remove-BitsTransfer" >NUL 2>&1

:DoLog
set h=%TIME:~0,2%
set m=%TIME:~3,2%
set s=%TIME:~6,2%
set EndTime=%h%.%m%.%s%

Echo(# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"%TEMP%\pwindoze.txt"
Echo(# PrivWindoze ^(%Log_PrivateWindows%^) v4.0.0>>"%TEMP%\pwindoze.txt"
Echo(# https://furtivex.net>>"%TEMP%\pwindoze.txt"
ECHO.# %Log_OS% + ^< WGA ^> %OS% %ARCH% %DisplayVersion% ^< %LicenseStatus% ^>>>"%TEMP%\pwindoze.txt"
ECHO.# %Log_Username% + ^< %Log_Date% ^> "%username%" ^< %StartTime% - %EndTime% ^>>>"%TEMP%\pwindoze.txt"
Echo(# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
ECHO(# %Log_Drivers%:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\000" (
  SORT_ -f -u <"%TEMP%\000" >"%TEMP%\000rdy"
  TYPE "%TEMP%\000rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(# %Log_Services%:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\000b" (
  SORT_ -f -u <"%TEMP%\000b" >"%TEMP%\000brdy"
  TYPE "%TEMP%\000brdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(# %Log_Files%:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
  IF EXIST "%TEMP%\001" (
  SORT_ -f -u <"%TEMP%\001" >"%TEMP%\001_rdy"
  TYPE "%TEMP%\001_rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(# %Log_Folders%>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\001b" (
  SORT_ -f -u <"%TEMP%\001b" >"%temp%\001brdy"
  TYPE "%TEMP%\001brdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(# %Log_Tasks%:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\002" (
  SORT_ -f -u <"%TEMP%\002" >"%TEMP%\002rdy"
  TYPE "%TEMP%\002rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(# %Log_Packages%:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\003" (
  SORT_ -f -u <"%TEMP%\003" >"%temp%\003rdy"
  TYPE "%TEMP%\003rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO(# %Log_Registry%:>>"%TEMP%\pwindoze.txt"
echo.>>"%TEMP%\pwindoze.txt"
IF EXIST "%TEMP%\004" (
  SORT_ -f -u <"%TEMP%\004" >"%temp%\004rdy"
  TYPE "%TEMP%\004rdy">>"%TEMP%\pwindoze.txt"
  echo.>>"%TEMP%\pwindoze.txt"
)

ECHO.# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #>>"%TEMP%\pwindoze.txt"
SED -r "s/(\x22|\x00+)//g; s/Sysnative/system32/; s/HKEY_LOCAL_MACHINE/HKLM/; s/HKEY_CURRENT_USER/HKCU/; s/HKEY_CLASSES_ROOT/HKCR/; s/HKEY_USERS/HKU/" <"%TEMP%\pwindoze.txt" >"%TEMP%\pwindoze_final.txt"

IF EXIST "%USERPROFILE%\OneDrive\Desktop" @COPY /Y "%TEMP%\pwindoze_final.txt" "%USERPROFILE%\OneDrive\Desktop\PrivWindoze_%StartTime%.txt" >NUL 2>&1
IF NOT EXIST "%USERPROFILE%\OneDrive\Desktop" @COPY /Y "%TEMP%\pwindoze_final.txt" "%USERPROFILE%\Desktop\PrivWindoze_%StartTime%.txt" >NUL 2>&1

:Abort
RD /S/Q %systemdrive%\PrivWindoze\dependencies >NUL 2>&1
IF %DEBUG%==OFF @DEL %windir%\grep.exe %windir%\libiconv2.dll %windir%\libintl3.dll %windir%\pcre3.dll %windir%\regex2.dll %windir%\sed.exe %windir%\sort_.exe %windir%\nircmd.exe >NUL 2>&1
FOR %%G in (
temp0?
appdata0?
sys32appdata0?
locala0?
windir0?
info0?
lang0?
quicklaunch0?
drivers0?
) DO @(
  DEL /F/Q "%CD%\%%G" >NUL 2>&1
  DEL /F/Q "%systemdrive%\PrivWindoze\%%G" >NUL 2>&1
)

ECHO.
ECHO.
START /D "%userprofile%" /I %WINDIR%\explorer.exe
DEL /F/S/Q "%TEMP%\*" >NUL 2>&1
RD /S/Q %systemdrive%\PrivWindoze >NUL 2>&1
:eof