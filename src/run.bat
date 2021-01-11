:: Simple Program Run Helper (run.bat)
:: -----------------------------------
:: u0r4 by Brendon, 01/23/2019.

@echo off

:: place program attributes here
set run_name=EDENdos u3r0
::set run_colr=
::set run_rows=
::set run_cols=
set run_cmnd=edendos.bat

:: place crucial program files here
set run_file[1]=edendos.bat
set run_file[2]=
set run_file[3]=
set run_file[4]=
set run_file[5]=
set run_file[6]=
set run_file[7]=
set run_file[8]=
set run_file[9]=
set run_file[0]=
goto run

:filecheck
    if not "%1" == "" (
        if not exist "%1" (
            echo ^<run/!^> %1 missing
            goto errorlanding
        )
    )
goto :eof

:run
title %run_name%
::color %run_colr%
::mode con lines=%run_rows%
::mode con cols=%run_cols%
call :filecheck %run_file[1]%
call :filecheck %run_file[2]%
call :filecheck %run_file[3]%
call :filecheck %run_file[4]%
call :filecheck %run_file[5]%
call :filecheck %run_file[6]%
call :filecheck %run_file[7]%
call :filecheck %run_file[8]%
call :filecheck %run_file[9]%
call :filecheck %run_file[0]%
cls
%run_cmnd%
goto :eof

:errorlanding
color 0c
echo:
echo ^<run/X^> An error is preventing the program from starting.
echo Press any key to quit.
pause > nul
exit /b 1


:: --------------
:: End of run.bat