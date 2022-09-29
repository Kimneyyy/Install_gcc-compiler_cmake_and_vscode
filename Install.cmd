@echo off
title Install Assistent by @VakeyYT and @Kimneyyy

:Titel
:: Require admin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------

:: You are admin

:: wich path you have to insert
set i_gcc=0
set i_cmake=0
set auswahl=0

echo Hallo, wilkommen bei der Installation.
echo Um Option zu waehlen bitte etsprechende Zahl eingeben und mit Enter bestaetigen.
echo:

:: Option waehle, wie installiert werden soll.
:option0
color 7
if %auswahl% NEQ 0 ( cls )
echo [1] TDM_GCC installieren
echo [2] CMake installieren
echo [3] VS_Code installieren
echo [4] Automatische Installation
echo [5] Manuell mit Doku installieren

:: check option
echo:
set /p auswahl= Option waehlen: 
echo:

if %auswahl% == 1 (goto :option1 )
if %auswahl% == 2 (goto :option2 )
if %auswahl% == 3 (goto :option3 )
if %auswahl% == 4 (goto :option4 )
if %auswahl% == 5 (goto :option5 )

goto :fehler

:fehler
cls
color 4
echo Ungueltige Eingabe
pause>NUL
goto :option0


:: Verschiedene Optionen
:: Option1
:option1
cls
echo               TDM_GCC Installation: 
echo:
echo:
echo       !!!!!!!!!!!!!!! LESEN !!!!!!!!!!!!!!!
echo:
echo Bitte zur Installation einwilligen und danach
echo folgende Optionen im neu geoefnetten Fenster waehlen:
echo:
echo Fenster 1: Create 
echo Fenster 2: MinGW-w64/TDM64 (32-bit and 64-bit)
echo Fenster 3: Installation Directory: C:\TDM-GCC-64
echo:

set /p input= Wollen Sie die Installation starten? [y]= Ja; [n]= Nein: 
echo:
if %input% NEQ y ( if %input% NEQ Y ( if %input% NEQ n ( if %input% NEQ N ( goto :fehler ) ) ) )
if %input% NEQ y ( if %input% NEQ Y ( goto :option0 ) )
set i_gcc=1
1_TDM_GCC\tdm64-gcc-9.2.0.exe

:: abfrage ob File erstellt wurde
echo:
cls
echo Installation war erfolgreich!!
echo:
if %auswahl% == 4 (goto :option2 ) else goto :option0
pause


:: Option2
:option2
cls
echo                 CMake Installation:
echo:
echo:
echo        !!!!!!!!!!!!!!! LESEN !!!!!!!!!!!!!!!
echo:
echo Bitte zur Installation einwilligen und danach
echo folgende Optionen im neu geoefnetten Fenster waehlen:
echo:
echo Fenster1: Add CMake to the system PATH for all users      oder     Install CMake for all users  
echo Fenster2: Pfad: C:\Program Files\CMake
echo:

set /p input= Wollen Sie die Installation starten? [y]= Ja; [n]= Nein: 
echo:
if %input% NEQ y ( if %input% NEQ Y ( if %input% NEQ n ( if %input% NEQ N ( goto :fehler ) ) ) )
if %input% NEQ y ( if %input% NEQ Y ( goto :option0 ) )
set i_cmake=1
2_CMake\cmake-3.19.4-win64-x64.msi

echo:
cls
echo Installation war erfolgreich
echo:
if %auswahl% == 4 (goto :option3 ) else goto :option0 
pause

:: Option3
:option3
cls
echo                    VSCode Installation:
echo:
set /p input= Wollen Sie die Installation starten? [y]= Ja; [n]= Nein: 
echo:
if %input% NEQ y ( if %input% NEQ Y ( if %input% NEQ n ( if %input% NEQ N ( goto :fehler ) ) ) )
if %input% NEQ y ( if %input% NEQ Y ( goto :option0 ) )

:: create new folder
set VSCodeTargetFolder=C:\Install\
if not exist "%VSCodeTargetFolder%" (mkdir %VSCodeTargetFolder%)
if exist "%VSCodeTargetFolder%VSCode_Portable" (set /p input= VSCode ist schon installiert. Trotzdem installieren? [y]= Ja; [n]= Nein: )
echo:
if %input% NEQ y ( if %input% NEQ Y ( if %input% NEQ n ( if %input% NEQ N ( goto :fehler ) ) ) )
if %input% NEQ y ( if %input% NEQ Y ( goto :option0 ) )

:: uzip VSCode
echo Installation lauft ...
echo Dies kann mehrere Minuten in Anpruch nehmen.
set myPath=%~dp0
set myDrive=%CD:~0,2% 
set zipPathName=%myPath%3_VSCode_Portable\VSCode_Portable.zip
::echo XX%mydrive%XX
::echo XX%myPath%XX
::echo %zipPathName%
c: 
cd %VSCodeTargetFolder%
tar -v -x -f %zipPathName%
cls
echo Result:
echo --------------------------------------------
cd VSCode_Portable
cd
dir /B
echo --------------------------------------------
%mydrive%         > nul 2>&1
cd %myFolder%     > nul 2>&1

:: in Path eintragen
:: set test=%Path%
set p=;%VSCodeTargetFolder%VSCode_Portable\bin
if %i_cmake% == 1 ( set p=%p%;C:\Program Files\CMake\bin)
if %i_gcc% == 1 ( set p=%p%;C:\TDM-GCC-64\bin)
setx -m Path "%Path%%p%"
pause

echo:
cls
echo:
echo Installation Abgeschlossen
echo:
pause
exit


:: Option4
:option4
cls
set /p input= Wollen Sie die automatische Installation starten? [y]= Ja; [n]= Nein: 
if %input% NEQ y ( if %input% NEQ Y ( if %input% NEQ n ( if %input% NEQ N ( goto :fehler ) ) ) )
if %input% NEQ y ( if %input% NEQ Y ( goto :option0 ) )
goto :option1
pause


:: Option5
:option5
wickie_vsc_installieren_v2.docx
pause
