@echo off

echo:
echo:
echo Initializing...
if not exist edendosd\ (echo Missing edendosd\. Abort... & goto :eof)
cmd /c edendosd\extcheck.bat > extcheck.log 2>&1 || (echo Extcheck failed. Abort... & goto :eof)
del extcheck.log
setlocal EnableExtensions
setlocal EnableDelayedExpansion
cd edendosd
set edendosd=!cd!
echo:
echo ------------------------------^<^^!^> GENERAL WARNING------------------------------
echo:
echo Any input instructions displayed on screen implies typing the characters
echo inside the double quotes and pressing the [enter] key.
echo:
echo EDENdos and its scripts come with no warranty.
echo:
echo -------------------------------------------------------------------------------
echo Press any key to proceed.
pause > nul
echo:
echo:
echo EDEN's DOS Portal (edendos.bat)
echo -------------------------------
echo u3r0 by Brendon, 01/23/2019.
echo:
echo:
echo Welcome !username!^^!
echo -------------------------------AVAILABLE SCRIPTS-------------------------------
echo adminchk  autocln  automen  calc  extcheck  formatwz  help  maccln  repeat
echo setupchk  TiTaTo
echo -------------------------------------------------------------------------------
echo:
echo Input your desired script(s). Multiple scripts can be separated with an
echo ampersand (^&). For example, "autocln & repeat".
echo:
echo Input "help" for more information. For help on a specific script, append
echo " help" to its name. For example, "autocln help".
echo:
echo Input "exit" to quit.
echo:
cmd /k prompt !username!@!computername!/EDENdos/_$G
cd ..
endlocal
echo:
echo:
echo ------------------
echo End of edendos.bat