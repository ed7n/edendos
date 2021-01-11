@echo off

echo:
echo:
goto run

:head
    echo Administrator Access Checker (adminchk.bat)
    echo -------------------------------------------
    echo u2r0 by Brendon, 01/23/2019.
    echo:
    echo Checks the presence of administrative permissions and exits if absent.
    ::echo "administrator password if absent."
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
echo ^<adminchk/i^> Checking superuser access...
net session > nul 2>&1
set edendos_err=%errorlevel%

if %edendos_err% NEQ 0 (
    echo ^<adminchk/X^> ...absent ^(exit status %edendos_err%^)
    call :end
    exit /b 1
)
echo ^<adminchk/i^> ...present
call :end
exit /b 0