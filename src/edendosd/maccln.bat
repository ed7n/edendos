@echo off

echo:
echo:
goto run

:head
    echo macOS Junk Cleaner (maccln.bat)
    echo -------------------------------
    echo u5r3 by Brendon, 01/23/2019.
    echo:
    echo Designed for Windows 10.
    echo:
    echo This script deletes the following:
    echo:
    echo   .fseventsd/ .Spotlight-V100/  .Trashes/  .DS_Store  ._*
    echo:
    echo These are junk files and folders created in directories of any removable
    echo disk inserted into a macOS computer.
    echo:
    echo macOS, formerly OS X, is a registered trademark of Apple Inc.
    echo:
    echo:
goto :eof

:help
    echo Usage: maccln ^<root^>
    echo:
    echo where ^<root^> is the root directory from which cleanup is to be executed.
    echo:
    echo Otherwise, this script is interactive.
goto :eof

:end
    echo:
    echo:
    echo -----------------
    echo End of maccln.bat
goto :eof

:cleanup
        echo:
        echo ^<maccln/i^> Begin macOS junk cleanup
        cd /d !edendos_inp!

        if not exist .fseventsd\ (
            echo ^<maccln/X^> Missing .fseventsd\
        ) else (
            rd /s /q .fseventsd > nul 2>&1
            echo ^<maccln/i^> Deleted .fseventsd
        )
        if not exist .Spotlight-V100\ (
            echo ^<maccln/X^> Missing .Spotlight-V100\
        ) else (
            rd /s /q .Spotlight-V100 > nul 2>&1
            echo ^<maccln/i^> Deleted .Spotlight-V100
        )
        if not exist .Trashes\ (
            echo ^<maccln/X^> Missing .Trashes\
        ) else (
            rd /s /q .Trashes > nul 2>&1
            echo ^<maccln/i^> Deleted .Trashes
        )
        echo ^<maccln/i^> Deleting all found .DS_Store...
        del /f /s /q .DS_Store > nul 2>&1
        echo ^<maccln/i^> Deleting all found ._*...
        del /f /s /q ._* > nul 2>&1
        echo ^<maccln/i^> End macOS junk cleanup
        cd /d !edendosd!
goto :eof

:run
if /i "%1" == "help" ( call :head & call :help & goto end )
echo Initializing...
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set edendosd=!cd!
set edendos_inp=NUL

if /i not "%*" == "" (
    set edendos_inp=%*
    echo:
    echo Will automatically clean !edendos_inp!
)
echo:
call :head
echo [ctrl+c] anytime to abort.

if /i not "%*" == "" (
    echo:

    if not exist !edendos_inp! (
        echo ^<maccln/X^> !edendos_inp! does not exist^^!
    ) else (
        call :cleanup
    )
    endlocal
    goto end
)
:input
    echo:
    echo ^<maccln/?^> Input root directory, "quit" to quit."
    set /p edendos_inp="<maccln/_> "
    if /i "!edendos_inp!" == "quit" goto end

    if not exist !edendos_inp! (
        echo ^<maccln/X^> !edendos_inp! does not exist^^!
    ) else (
        call :cleanup
        endlocal
        goto end
    )
goto :input