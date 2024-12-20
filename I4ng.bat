:: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-input-locales-for-windows-language-packs?view=windows-11
REG QUERY HKLM\System\CurrentControlSet\Control\NLS\Language /V Default 2>NUL|GREP -Es "REG_SZ">lang00
IF ERRORLEVEL 1 GOTO :English
SED -r "s/^    Default    REG_SZ    ([A-F0-9]{4})/\1/" <lang00 >lang01
FOR /F %%G in (lang01) DO SET LanguageCode=%%G
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
GREP -isq "09$" lang01 && GOTO :English
GREP -isq "0A$" lang01 && GOTO :Spanish
GREP -isq "07$" lang01 && GOTO :German
GREP -isq "0415" lang01 && GOTO :Polish
GREP -isq "16$" lang01 && GOTO :Portuguese
GREP -isq "0419" lang01 && GOTO :Russian
GREP -isq "0405" lang01 && GOTO :Czech
GREP -isq "[08|04]04" lang01 && GOTO :Chinese
GREP -isq "0C$" lang01 && GOTO :French

REM ~~~~~~~~~~~~~~~~~~~~~~~~>
:English
@SET "Disclaimer=PrivWindoze (Private Windows) is permitted for non-commercial~npurposes only. It is a tool to disable telemetry and~nbloatwareby uninstalling offending (intrusive) programs,~nand updating policies to better protect the user.~n~nWarning! It deletes Microsoft Edge. You need an alternate~nbrowser installed prior to continuing.~n~nOfficial Download Links:~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe~nPlease save your work before proceeding. The tool will~nclose all non-essential windows during its operation.~n~nThis software is provided 'as is', without warranty of~nany kind. All implied warranties are expressly disclaimed.~nIf you do not agree to the above terms, please click No~nto exit." "DISCLAIMER OF WARRANTY ON SOFTWARE."
@SET "Log_Username=User"
@SET "Log_OS=Operating system"
@SET "Log_Date=Date"
@SET "Log_Services=Services"
@SET "Log_Drivers=Drivers"
@SET "Log_Files=Files"
@SET "Log_Folders=Folders"
@SET "Log_Packages=Packages"
@SET "Log_Tasks=Tasks"
@SET "Log_Registry=Registry"
@SET "Log_Miscellaneous=Miscellaneous"
@SET "Scan_ThereWillBeLog=There will be a log on your desktop when the scan completes"
@SET "Log_FWNoFile=No File"
@SET "Log_SVCDelete=Service Deleted"
@SET "Log_SVCStopped=Service Stopped"
@SET "Log_SVCDisabled=Service Disabled"
@SET "Log_Repairs=Attempted Repairs"
@SET "Scan_IsMissing=is missing"
@SET "Log_PrivateWindows=Private Windows"
GOTO :eof

:Spanish
@SET "Disclaimer=PrivWindoze (Ventanas privadas) solo está permitido para~nfines no comerciales. Es una herramienta para deshabilitar~nla telemetría y el bloatware mediante la desinstalación de~nprogramas ofensivos (intrusivos) y la actualización de~npolíticas para proteger mejor al usuario.~n~n¡Advertencia! Elimina Microsoft Edge. Necesita instalar~nuna alternativa antes de continuar.~n~nEnlaces de descarga oficiales:~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe~nGuarde su trabajo antes de continuar. La herramienta~ncerrará todas las ventanas no esenciales durante su~nfuncionamiento. Este software se proporciona 'tal cual',~nsin garantía de ningún tipo. Se renuncia expresamente a~ntodas las garantías implícitas. Si no está de acuerdo~ncon los términos anteriores, haga clic en No para salir." "RENUNCIA DE GARANTÍA SOBRE EL SOFTWARE."
@SET "Log_Username=Usuario"
@SET "Log_OS=Sistema operativo"
@SET "Log_Date=Fecha"
@SET "Log_Services=Servicios"
@SET "Log_Drivers=Controladores"
@SET "Log_Files=Archivos"
@SET "Log_Folders=Carpetas"
@SET "Log_Packages=Paquetes"
@SET "Log_Tasks=Tareas"
@SET "Log_Registry=Registro"
@SET "Log_Miscellaneous=Misceláneo"
@SET "Scan_ThereWillBeLog=Habrá un registro en su escritorio cuando se complete el escaneo"
@SET "Log_FWNoFile=Sin archivo"
@SET "Log_SVCDelete=Servicio eliminado"
@SET "Log_SVCStopped=Servicio detenido"
@SET "Log_SVCDisabled=Servicio deshabilitado"
@SET "Log_Repairs=Tentatives de réparation"
@SET "Scan_IsMissing=Falta"
@SET "Log_PrivateWindows=Ventanas privadas"
GOTO :eof

:German
@SET "Disclaimer=PrivWindoze (Privat Fenster) ist nur für nicht-kommerzielle~nZwecke gestattet. Es handelt sich um ein Tool zum~nDeaktivieren von Telemetrie und Bloatware, indem anstößige~n(aufdringliche) Programme deinstalliert und Richtlinien~naktualisiert werden, um den Benutzer besser zu schützen.~n~nWarnung! Microsoft Edge wird gelöscht. Bevor Sie fortfahren~nkönnen, muss eine Alternative installiert sein.~n~nOffizielle Download-Links:~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe~n~nBitte speichern Sie Ihre Arbeit, bevor Sie fortfahren.~nDas Tool schließt während des Betriebs alle nicht wesentlichen~nFenster. Diese Software wird ohne Mängelgewähr und ohne~njegliche Gewährleistung zur Verfügung gestellt. Alle~nstillschweigenden Garantien werden ausdrücklich abgelehnt.~nWenn Sie mit den oben genannten Bedingungen nicht~neinverstanden sind, klicken Sie bitte auf Nein, um den~nVorgang zu beenden." "GEWÄHRLEISTUNGSAUSSCHLUSS FÜR SOFTWARE."
@SET "Log_Username=Benutzer"
@SET "Log_OS=Betriebssystem"
@SET "Log_Date=Datum"
@SET "Log_Services=Dienste"
@SET "Log_Files=Dateien"
@SET "Log_Drivers=Treiber"
@SET "Log_Folders=Ordner"
@SET "Log_Packages=Pakete"
@SET "Log_Tasks=Aufgaben"
@SET "Log_Registry=Registrierung"
@SET "Log_Miscellaneous=Verschiedenes"
@SET "Scan_ThereWillBeLog=Nach Abschluss des Scanvorgangs wird ein Protokoll auf Ihrem Desktop angezeigt."
@SET "Log_FWNoFile=Keine Datei"
@SET "Log_SVCDelete=Dienst gelöscht"
@SET "Log_SVCStopped=Dienst gestoppt"
@SET "Log_SVCDisabled=Dienst deaktiviert"
@SET "Log_Repairs=Versuchte Reparaturen"
@SET "Scan_IsMissing=fehlt"
@SET "Log_PrivateWindows=Private Fenster"
GOTO :eof

:Polish
@SET "Disclaimer=PrivWindoze (Prywatny Windows) jest dozwolony wylacznie~ndo celów niekomercyjnych. Jest to narzedzie do wylaczania~ntelemetrii i bloatware poprzez odinstalowywanie obrazliwych~n(natretnych) programów i aktualizowanie zasad w celu~nlepszej ochrony uzytkownika.~n~nOstrzezenie! Usuwa przegladarke Microsoft Edge. Zanim~nprzejdziesz dalej, musisz zainstalowac alternatywe.~n~nOficjalne linki do pobrania:~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe Zapisz swoja~nprace przed kontynuowaniem. Narzedzie zamknie~nwszystkie zbedne okna podczas jego dzialania. To~noprogramowanie jest dostarczane w stanie, w jakim~nsie znajduje, bez jakichkolwiek gwarancji. Wszelkie~ndorozumiane gwarancje sa wyraznie wylaczone. Jesli~nnie zgadzasz sie z powyzszymi warunkami, kliknij~nprzycisk Nie, aby wyjsc." "WYLACZENIE ODPOWIEDZIALNOSCI Z TYTULU GWARANCJI NA OPROGRAMOWANIE."
@SET "Log_Username=Użytkownik"
@SET "Log_OS=System operacyjny"
@SET "Log_Date=Data"
@SET "Log_Services=Usługi"
@SET "Log_Files=Pliki"
@SET "Log_Folders=Folderów"
@SET "Log_Packages=Pakiety"
@SET "Log_Drivers=Sterowniki"
@SET "Log_Tasks=Zadania"
@SET "Log_Registry=Rejestr"
@SET "Log_Miscellaneous=Rozmaity"
@SET "Scan_ThereWillBeLog=Po zakończeniu skanowania na pulpicie pojawi się dziennik"
@SET "Log_FWNoFile=Brak pliku"
@SET "Log_SVCDelete=Usługa usunięta"
@SET "Log_SVCStopped=Usługa zatrzymana"
@SET "Log_SVCDisabled=Usługa wyłączona"
@SET "Log_Repairs=Próby naprawy"
@SET "Scan_IsMissing=brakuje"
@SET "Log_PrivateWindows=Okna prywatne"
GOTO :eof

:Portuguese
@SET "Disclaimer=O PrivWindoze (Privado Windows) é permitido apenas para~nfins não comerciais. É uma ferramenta para desabilitar a~ntelemetria e o bloatware, desinstalando programas ofensivos~n(intrusivos) e atualizando as políticas para proteger~nmelhor o usuário.~n~nAviso! Ele exclui o Microsoft Edge. Você precisa de uma~nalternativa instalada antes de continuar.~n~nLinks oficiais para download:~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe~n~nSalve seu trabalho antes de prosseguir. A ferramenta~nfechará todas as janelas não essenciais durante sua~noperação. Este software é fornecido 'no estado em que~nse encontra', sem garantia de qualquer tipo. Todas~nas garantias implícitas são expressamente renunciadas.~nSe você não concordar com os termos acima, clique em~nNão para sair." "ISENÇÃO DE GARANTIA DO SOFTWARE."
@SET "Log_Username=Utilizador"
@SET "Log_OS=Sistema Operacional"
@SET "Log_Date=Data"
@SET "Log_Services=Serviços"
@SET "Log_Files=Limas"
@SET "Log_Drivers=Drivers"
@SET "Log_Folders=Pastas"
@SET "Log_Packages=Pacotes"
@SET "Log_Tasks=Tarefas"
@SET "Log_Registry=Registro"
@SET "Log_Miscellaneous=Variado"
@SET "Scan_ThereWillBeLog=Haverá um log em sua área de trabalho quando a verificação for concluída"
@SET "Log_FWNoFile=Nenhum arquivo"
@SET "Log_SVCDelete=Serviço excluído"
@SET "Log_SVCStopped=Serviço interrompido"
@SET "Log_SVCDisabled=Serviço desativado"
@SET "Log_Repairs=Tentativas de reparos"
@SET "Scan_IsMissing=está faltando"
@SET "Log_PrivateWindows=Janelas privadas"
GOTO :eof

:Russian
@SET "Disclaimer=PrivWindoze (Частные окна) разрешен только в некоммерческих~nцелях. Это средство для отключения телеметрии и раздутого ПО~nпутем удаления вредоносных (навязчивых) программ и обновления~nполитик для лучшей защиты пользователя. Предупреждение! При~nэтом будет удален Microsoft Edge. Прежде чем продолжить,~nнеобходимо установить альтернативный вариант. Официальные~n~nссылки для скачивания:~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe~n~nПожалуйста, сохраните свою работу, прежде чем продолжить.~nИнструмент закроет все несущественные окна во время своей~nработы. Это программное обеспечение предоставляется «как есть»,~nбез каких-либо гарантий. Мы категорически отказываемся от~nвсех подразумеваемых гарантий. Если вы не согласны с~nвышеуказанными условиями, нажмите «Нет», чтобы выйти." "ОТКАЗ ОТ ГАРАНТИЙ НА ПРОГРАММНОЕ ОБЕСПЕЧЕНИЕ."
@SET "Log_Username=Пользователь"
@SET "Log_OS=Операционная система"
@SET "Log_Date=Дата"
@SET "Log_Services=Услуги"
@SET "Log_Files=Файлы"
@SET "Log_Drivers=Драйверы"
@SET "Log_Folders=Папки"
@SET "Log_Packages=Пакеты"
@SET "Log_Tasks=Задачи"
@SET "Log_Registry=Регистратура"
@SET "Log_Miscellaneous=Смешанный"
@SET "Scan_ThereWillBeLog=По завершении сканирования на рабочем столе появится журнал"
@SET "Log_FWNoFile=Нет файла"
@SET "Log_SVCDelete=Услуга удалена"
@SET "Log_SVCStopped=Обслуживание остановлено"
@SET "Log_SVCDisabled=Обслуживание отключено"
@SET "Log_Repairs=Попытки ремонта"
@SET "Scan_IsMissing=отсутствует"
@SET "Log_PrivateWindows=Частные окна"
GOTO :eof


:Czech
@SET "Disclaimer=PrivWindoze (Soukromá okna) je povolena pouze pro~nnekomercní úcely. Jedná se o nástroj pro deaktivaci~ntelemetrie a bloatwaru odinstalováním problematických~n(rušivých) programu a aktualizací zásad pro lepší ochranu~nuživatele.~n~nVarování! Odstraní Microsoft Edge. Než budete moci~npokracovat, musíte nainstalovat alternativu.~n~nOficiální odkazy ke stažení:~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe Než budete~npokracovat, uložte svou práci. Nástroj behem své~ncinnosti zavre všechna nepodstatná okna. Tento~nsoftware je poskytován "tak, jak je", bez jakékoli~nzáruky. Všechny predpokládané záruky jsou výslovne~nodmítnuty. Pokud s výše uvedenými podmínkami nesouhlasíte,~nukoncete je kliknutím na tlacítko Ne." "ZREKNUTÍ SE ZÁRUKY NA SOFTWARE."
@SET "Log_Username=Uživatel"
@SET "Log_OS=Operační systém"
@SET "Log_Date=Rande"
@SET "Log_Services=Služby"
@SET "Log_Files=Soubory"
@SET "Log_Drivers=Ovladače"
@SET "Log_Folders=Šanony"
@SET "Log_Packages=Balíky"
@SET "Log_Tasks=Úkoly"
@SET "Log_Registry=Registr"
@SET "Log_Miscellaneous=Rozmanitý"
@SET "Scan_ThereWillBeLog=Po dokončení skenování se na ploše zobrazí protokol"
@SET "Log_FWNoFile=Žádný soubor"
@SET "Log_SVCDelete=Služba odstraněna"
@SET "Log_SVCStopped=Služba zastavena"
@SET "Log_SVCDisabled=Služba zakázána"
@SET "Log_Repairs=Pokusy o opravu"
@SET "Scan_IsMissing=chybí"
@SET "Log_PrivateWindows=Soukromá okna"
GOTO :eof

:Chinese
@SET "Disclaimer=PrivWindoze （私人 窗户） 仅允许~n用于非商业目的。它是一种通过卸载违规（侵入~n性）程序和更新策略来禁用遥测和膨胀软件以~n更好地保护用户的工具。~n~n警告！它会删除 Microsoft Edge。~n在继续之前，您需要安装~n备用设备。~n~n官方下载链接：~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe~n~n请在继续之前保存您的工作。~n该工具将在运行过程中关闭所有~n不必要的窗口。本软件按"原样"~n提供，不提供任何形式的保证。所~n有默示保证均明确否认。如果~n您不同意上述条款，请点击~n否" "退出。软件免责声明。"
@SET "Log_Username=用户"
@SET "Log_OS=操作系统"
@SET "Log_Date=日期"
@SET "Log_Services=服务业"
@SET "Log_Drivers=司机"
@SET "Log_Files=文件"
@SET "Log_Folders=包"
@SET "Log_Packages=Packages"
@SET "Log_Tasks=任务"
@SET "Log_Registry=注册表"
@SET "Log_Miscellaneous=杂项"
@SET "Scan_ThereWillBeLog=扫描完成后，您的桌面上将有一个日志"
@SET "Log_FWNoFile=无文件"
@SET "Log_SVCDelete=服务已删除"
@SET "Log_SVCStopped=服务已停止"
@SET "Log_SVCDisabled=服务已禁用"
@SET "Log_Repairs=尝试修复"
@SET "Scan_IsMissing=缺失"
@SET "Log_PrivateWindows=私有窗口"
GOTO :eof

:French
@SET "Disclaimer=PrivWindoze (Privé Windows) n'est autorisé qu'à des fins~nnon commerciales. Il s'agit d'un outil permettant de~ndésactiver la télémétrie et les bloatwares en désinstallant~nles programmes incriminés (intrusifs) et en mettant à jour~nles politiques pour mieux protéger l'utilisateur.~n~nAvertissement! Il supprime Microsoft Edge. Vous devez~ninstaller un autre appareil avant de continuer.~n~nLiens de téléchargement officiels :~nhttps://furtivex.net/PrivWindoze.exe~nhttps://furtivex.net/PrivWindozeLite.exe~n~nVeuillez enregistrer votre travail avant de continuer.~nL'outil fermera toutes les fenêtres non essentielles~npendant son fonctionnement. Ce logiciel est fourni~n« en l'état », sans garantie d'aucune sorte. Toutes les~ngaranties implicites sont expressément exclues. Si vous~nn'êtes pas d'accord avec les conditions ci-dessus,~nveuillez cliquer sur Non pour quitter." "EXCLUSION DE GARANTIE SUR LE LOGICIEL."
@SET "Log_Username=Utilisateur"
@SET "Log_OS=Système d'exploitation"
@SET "Log_Date=Date"
@SET "Log_Services=Services"
@SET "Log_Drivers=Pilotes"
@SET "Log_Files=Fichiers"
@SET "Log_Folders=Dossiers"
@SET "Log_Packages=Paquets"
@SET "Log_Tasks=Tâches"
@SET "Log_Registry=Registre"
@SET "Log_Miscellaneous=Divers"
@SET "Scan_ThereWillBeLog=Un journal s'affichera sur votre bureau une fois l'analyse terminée"
@SET "Log_FWNoFile=Aucun fichier"
@SET "Log_SVCDelete=Service supprimé"
@SET "Log_SVCStopped=Service arrêté"
@SET "Log_SVCDisabled=Service désactivé"
@SET "Log_Repairs=Tentatives de réparation"
@SET "Scan_IsMissing=est manquant"
@SET "Log_PrivateWindows=Fenêtres privées"
GOTO :eof

:eof
EXIT /B