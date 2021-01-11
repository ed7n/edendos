@echo off

echo:
echo:
goto run

:head
    echo Windows Automated Maintenance (automen.bat)
    echo -------------------------------------------
    echo u6r4 by Brendon, 01/23/2019.
    echo:
    echo Automatically cleans and optimizes your system.
    echo:
    echo Designed for Windows 10.
    echo:
    echo:
goto :eof

:help
    echo Usage: automen ^<forceadmin^> ^<option^>
    echo:
    echo where ^<option^> can be any of the following:
    echo:
    echo   shutdown     Shuts down system after maintenance
    echo   restart      Restarts system after maintenance
    echo   signout      Signs the current user out after maintenance
    echo   reexplore    Restarts Windows Explorer after maintenance
    echo:
    echo   forceadmin   Bypasses adminchk, for use with Safe Mode only
goto :eof

:end
    echo:
    echo:
    echo ------------------
    echo End of automen.bat
goto :eof

:run
if /i "%1" == "help" ( call :head & call :help & goto end )
echo Initializing...

if /i not "%1" == "forceadmin" (
    cmd /c adminchk.bat > nul 2>&1 || ( echo Adminchk failed. Abort... & goto :eof )
) else (
    echo:
    echo adminchk bypassed, script may not run properly
    shift
)
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set edendos_out=

if /i "%1" == "shutdown" (
    set "edendos_out=( taskkill /f /im explorer.exe & shutdown /p ) > nul 2>&1"
    echo:
    echo Will shutdown after maintenance
)
if /i "%1" == "restart" (
    set "edendos_out=( taskkill /f /im explorer.exe & shutdown /r /t 0 ) > nul 2>&1"
    echo:
    echo Will restart after maintenance
)
if /i "%1" == "signout" (
    set "edendos_out=( taskkill /f /im explorer.exe & shutdown /l ) > nul 2>&1"
    echo:
    echo Will sign out after maintenance
)
if /i "%1" == "reexplore" (
    set "edendos_out=( taskkill /f /im explorer.exe & explorer ) > nul 2>&1"
    echo:
    echo Will restart Explorer after maintenance
)
set edendosd=!cd!
set automen_s=start /wait
set automen_sb=start /b /wait
echo:
call :head
echo [ctrl+c] anytime to abort. Press any key to proceed.
timeout 5 > nul
echo:
echo:
echo ^<automen/^^!^> Begin system maintenance
echo:

:: CCleaner
if not "!processor_architecture!" == "x86" (
    if not exist "CCleaner\CCleaner64.exe" (
        echo ^<automen/X^> Missing CCleaner64^^!
    ) else (
        echo ^<automen/i^> Running CCleaner64...^(1/11^)
        !automen_s! /d "!edendosd!\CCleaner\" CCleaner64.exe /auto > nul 2>&1
    )
) else (
    if not exist "CCleaner\CCleaner.exe" (
        echo ^<automen/X^> Missing CCleaner^^!
    ) else (
        echo ^<automen/i^> Running CCleaner...^(1/11^)
        !automen_s! /d "!edendosd!\CCleaner\" CCleaner.exe /auto > nul 2>&1
    )
)
echo:

:: Wise Disk Cleaner
if not exist "Wise Disk Cleaner\WiseDiskCleaner.exe" (
    echo ^<automen/X^> Missing Wise Disk Cleaner^^!
) else (
    echo ^<automen/i^> Running Wise Disk Cleaner...^(2/11^)
    !automen_s! /d "!edendosd!\Wise Disk Cleaner\" WiseDiskCleaner.exe -a > nul 2>&1
)
echo:

:: Wise Registry Cleaner
if not exist "Wise Registry Cleaner\WiseRegCleaner.exe" (
    echo ^<automen/X^> Missing Wise Registry Cleaner^^!
) else (
    echo ^<automen/i^> Running Wise Registry Cleaner...^(3/11^)
    !automen_s! /d "!edendosd!\Wise Registry Cleaner\" WiseRegCleaner.exe -a -all > nul 2>&1
)
echo:

:: BleachBit
if not exist "BleachBit-Portable\BleachBit.exe" (
    echo ^<automen/X^> Missing BleachBit^^!
) else (
    echo ^<automen/i^> Running BleachBit...^(4/11^)
    !automen_s! /d "!edendosd!\BleachBit-Portable\" bleachbit_console.exe --no-uac --preset --clean > nul 2>&1
)
echo:
echo ^<automen/i^> Deleting shadow backup files...^(5/11^)
    !automen_sb! vssadmin delete shadows /all /quiet > nul 2>&1
echo:
echo ^<automen/i^> Clearing Shellbags...^(6/11^)
    !automen_sb! reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell" /f > nul 2>&1
    !automen_sb! reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell" /f > nul 2>&1
    !automen_sb! reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\BagMRU" /f > nul 2>&1
    !automen_sb! reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Bags" /f > nul 2>&1
echo:
echo ^<automen/i^> Deleting temporary files...^(7/11^)
    del /f /s /q "!temp!\*" > nul 2>&1
    del /f /s /q "!systemdrive!\Windows\Temp\*" > nul 2>&1
echo:
echo ^<automen/i^> Deleting Windows Update files...^(8/11^)
    !automen_sb! net stop wuauserv > nul 2>&1
    del /f /s /q "!windir!\SoftwareDistribution\*" > nul 2>&1
echo:

:: Windows Component Store
ver | findstr /C:"6.3.9600" /C:"[Version 10." > nul 2>&1 & set edendos_err=!errorlevel!

if !edendos_err! EQU 1 (
    echo ^<automen/X^> Windows Component Store cleanup requires Windows 8.1 or newer^^!
) else (
    echo ^<automen/i^> Cleaning Windows Component Store...^(9/11^)
    dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase > nul 2>&1
)
echo:
echo ^<automen/i^> Deleting residual files and directories...^(10/11^)
    rd /s /q "!APPDATA!\Wise Disk Cleaner" "!APPDATA!\Wise Registry Cleaner" > nul 2>&1
echo:
echo ^<automen/i^> Optimizing disk...^(11/11^)
    !automen_sb! defrag /c > nul 2>&1
echo:
echo ^<automen/i^> End system maintenance
cd /d !edendosd!
%edendos_out%
endlocal
goto end