@echo off

echo:
echo:
goto run

:head
    echo Command Extensions Checker (extcheck.bat)
    echo -----------------------------------------
    echo u0r2 by Brendon, 01/23/2019.
    echo:
    echo Checks the presence of command extensions.
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
echo ^<extcheck/i^> Checking command extensions...
:: ack: https://ss64.org/viewtopic.php?pid=7494#p7494
if "~x0" == "%~x0"   goto na
if "%%~x0" == "%~x0" goto na
if cmdextversion 2   goto v2
goto v1

:v1
echo ^<extcheck/i^> Found CMDEXT 1
goto no

:v2
echo ^<extcheck/i^> Found CMDEXT %cmdextversion%
goto yes

:na
echo ^<extcheck/i^> Found CMDEXT n/a
goto no

:no
echo ^<extcheck/X^> ...unsupported or version mismatch
exit /b 1

:yes
echo ^<extcheck/i^> ...supported
call :end
exit /b 0