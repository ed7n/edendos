@echo off

echo:
echo:
goto run

:head
    echo Tic-Tac-Toe (TiTaTo.bat)
    echo ------------------------
    echo u2r3 by Brendon, 01/23/2019.
    echo:
    echo:
goto :eof

:help
    echo Help is unavailable for this script.
    echo:
    echo This script is interactive.
goto :eof

:end
    echo:
    echo:
    echo -----------------
    echo End of TiTaTo.bat
goto :eof

:turn
    set TTT_temp[0]=!TTT_status!

    :turnwhile
    if "!TTT_temp[0]!" == "!TTT_status!" (
        echo:
        echo:
        echo   !TTT_cell[1]! !TTT_cell[2]! !TTT_cell[3]!
        echo   !TTT_cell[4]! !TTT_cell[5]! !TTT_cell[6]!
        echo   !TTT_cell[7]! !TTT_cell[8]! !TTT_cell[9]!
        echo:
        choice /c 123456789 /n /cs /m "<TiTaTo/_> Player !TTT_status!, place your mark [1-9]: "
        set edendos_inp=!errorlevel!
        if !edendos_inp! == 1 set TTT_temp[1]=!TTT_cell[1]!
        if !edendos_inp! == 2 set TTT_temp[1]=!TTT_cell[2]!
        if !edendos_inp! == 3 set TTT_temp[1]=!TTT_cell[3]!
        if !edendos_inp! == 4 set TTT_temp[1]=!TTT_cell[4]!
        if !edendos_inp! == 5 set TTT_temp[1]=!TTT_cell[5]!
        if !edendos_inp! == 6 set TTT_temp[1]=!TTT_cell[6]!
        if !edendos_inp! == 7 set TTT_temp[1]=!TTT_cell[7]!
        if !edendos_inp! == 8 set TTT_temp[1]=!TTT_cell[8]!
        if !edendos_inp! == 9 set TTT_temp[1]=!TTT_cell[9]!

        if not "!TTT_temp[1]!" == "NUL" (

            if "!TTT_temp[1]!" == "-" (
                set TTT_cell[!edendos_inp!]=!TTT_status!

                if "!TTT_status!" == "O" set TTT_temp[0]=X
                if "!TTT_status!" == "X" set TTT_temp[0]=O
            ) else (
                echo ^<TiTaTo/X^> Cell already occupied!
            )
        ) else (
            echo:
            echo ^<TiTaTo/X^> Invalid input^^!
        )
        set TTT_temp[1]=NUL
        goto turnwhile
    )
    set TTT_status=!TTT_temp[0]!
    set /a TTT_inputs+=1
goto :eof

:check
    set TTT_temp[0]=!TTT_status!
    set TTT_status=END

    if "!TTT_temp[0]!" == "O" set TTT_temp[1]=X
    if "!TTT_temp[0]!" == "X" set TTT_temp[1]=O
    set edendos_out=!TTT_temp[1]! wins^^!

    :: cross
    if "!TTT_cell[5]!" == "!TTT_temp[1]!" (
        if "!TTT_cell[1]!!TTT_cell[5]!!TTT_cell[9]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
        if "!TTT_cell[3]!!TTT_cell[5]!!TTT_cell[7]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
        if "!TTT_cell[4]!!TTT_cell[5]!!TTT_cell[6]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
        if "!TTT_cell[2]!!TTT_cell[5]!!TTT_cell[8]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
    )
    :: borders
    if "!TTT_cell[1]!" == "!TTT_temp[1]!" (
        if "!TTT_cell[1]!!TTT_cell[2]!!TTT_cell[3]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
        if "!TTT_cell[1]!!TTT_cell[4]!!TTT_cell[7]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
    )
    if "!TTT_cell[9]!" == "!TTT_temp[1]!" (
        if "!TTT_cell[7]!!TTT_cell[8]!!TTT_cell[9]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
        if "!TTT_cell[3]!!TTT_cell[6]!!TTT_cell[9]!" == "!TTT_temp[1]!!TTT_temp[1]!!TTT_temp[1]!" goto :eof
    )
    if !TTT_inputs! GEQ 9 (
        set edendos_out=Draw
        goto :eof
    )
    set TTT_status=!TTT_temp[0]!
goto :eof

:game
    if not "!TTT_status!" == "END" (
        call :turn
        call :check
        goto game
    )
    echo:
    echo:
    echo   !TTT_cell[1]! !TTT_cell[2]! !TTT_cell[3]!
    echo   !TTT_cell[4]! !TTT_cell[5]! !TTT_cell[6]!
    echo   !TTT_cell[7]! !TTT_cell[8]! !TTT_cell[9]!
    echo:
    echo ^<TiTaTo/^^!^> !edendos_out!
    echo Press any key to quit.
    pause > nul
    endlocal
    goto end
goto :eof

:run
if /i "%1" == "help" ( call :head & call :help & goto end )
echo Initializing...
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set edendos_out=NUL
set edendos_inp=NUL
set TTT_temp[0]=NUL
set TTT_temp[1]=NUL
set TTT_cell[1]=-
set TTT_cell[2]=-
set TTT_cell[3]=-
set TTT_cell[4]=-
set TTT_cell[5]=-
set TTT_cell[6]=-
set TTT_cell[7]=-
set TTT_cell[8]=-
set TTT_cell[9]=-
set TTT_inputs=0
if %random% LSS 16384 ( set "TTT_status=O" ) else ( set "TTT_status=X" )
echo:
call :head
echo Tic-Tac-Toe is 2-player game. Each player take turns marking a 3 x 3 grid.
echo The first player that succeeds in placing 3 adjacent marks wins.
echo:
echo Cell reference:
echo:
echo   1 2 3
echo   4 5 6
echo   7 8 9
echo:
echo [ctrl+c] anytime to abort. Press any key to proceed.
pause > nul
goto game