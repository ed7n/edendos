@echo off

echo:
echo:
goto run

:head
    echo Automen Setup Checker (setupchk.bat)
    echo ------------------------------------
    echo u1r3 by Brendon, 01/23/2019.
    echo:
    echo Checks the presence of optional third-party programs.
    echo:
    echo:
goto :eof

:help
    echo Help is unavailable for this script.
goto :eof

:end
    echo:
    echo:
goto :eof

:run
if /i "%1" == "help" ( call :head & call :help & goto end )
set edendosd=%cd%
echo ^<setupchk/i^> Checking automen setup...

:: CCleaner
if exist "%edendosd%\CCleaner\CCleaner.exe" (
    echo ^<setupchk/i^> ...found CCleaner...
) else (
    if exist %edendosd%\CCleaner\CCleaner64.exe (
        echo ^<setupchk/i^> ...found CCleaner...
    ) else (
        echo ^<setupchk/X^> ...missing CCleaner...
    )
)

:: Wise Disk Cleaner
if exist "%edendosd%\Wise Disk Cleaner\WiseDiskCleaner.exe" (
    echo ^<setupchk/i^> ...found Wise Disk Cleaner...
) else (
    echo ^<setupchk/X^> ...missing Wise Disk Cleaner...
)

:: Wise Registry Cleaner
if exist "%edendosd%\Wise Registry Cleaner\WiseRegCleaner.exe" (
    echo ^<setupchk/i^> ...found Wise Registry Cleaner...
) else (
    echo ^<setupchk/X^> ...missing Wise Registry Cleaner...
)

:: BleachBit
if exist "%edendosd%\BleachBit-Portable\bleachbit_console.exe" (
    echo ^<setupchk/i^> ...found BleachBit...
) else (
    echo ^<setupchk/X^> ...missing BleachBit...
)
echo ^<setupchk/i^> ...done
goto end