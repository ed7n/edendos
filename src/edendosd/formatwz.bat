@echo off

echo:
echo:
goto run

:head
    echo Disk Format Wizard (formatwz.bat)
    echo ---------------------------------
    echo u4r3 by Brendon, 01/23/2019.
    echo:
    echo A wizard to formatting a disk.
    echo:
    echo Designed for Windows 10.
    echo:
    echo:
goto :eof

:help
    echo Help is unavailable for this script.
    echo:
    echo This script is interactive.
    echo:
    echo To format a disk without interaction, use the "format" command.
    echo Input "format /?" for more information.
goto :eof

:end
    echo:
    echo:
    echo -------------------
    echo End of formatwz.bat
goto :eof

:run
if /i "%1" == "help" ( call :head & call :help & goto end )
echo Initializing...
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set edendosd=!cd!
set edendos_inp=NUL
set edendos_err=NUL
set formatwz_volm=NUL
set formatwz_fsys=NUL
set formatwz_opts=NUL
set formatwz_mode=NUL
set formatwz_labl=NUL
echo:
call :head
echo [ctrl+c] anytime to abort.
goto wizard

:wizard
echo:
goto volm

:volm
echo:
set formatwz_volm=NUL
set /p formatwz_volm="(1/5) Input volume letter, "quit" to quit: "
if /i "!formatwz_volm!" == "quit" goto end

if not exist !formatwz_volm!:\ (
    echo ^<formatwz/X^> Volume !formatwz_volm!:\ does not exist^^!
    goto volm
)
goto fsys

:fsys
echo:
echo ^(2/5^) File System
echo -----------------
echo [1] FAT32  [2] NTFS  [3] FAT  [4] exFAT  [5] UDF  [6] ReFS
echo [0] Back
echo:
choice /c 1234560 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 ( set "formatwz_fsys=FAT32" & goto opts )
if !edendos_inp! EQU 2 ( set "formatwz_fsys=NTFS"  & goto opts )
if !edendos_inp! EQU 3 ( set "formatwz_fsys=FAT"   & goto opts )
if !edendos_inp! EQU 4 ( set "formatwz_fsys=exFAT" & goto opts )
if !edendos_inp! EQU 5 ( set "formatwz_fsys=UDF"   & goto opts )
if !edendos_inp! EQU 6 ( set "formatwz_fsys=ReFS"  & goto opts )
if !edendos_inp! EQU 7 goto volm
goto fsys

:opts
set formatwz_opts=
if "!formatwz_fsys!" == "NTFS" goto NTFS
if "!formatwz_fsys!" == "UDF"  goto UDF
if "!formatwz_fsys!" == "ReFS" goto ReFS
goto qf

:NTFS
echo:
echo ^(2a/5^) NTFS compression?  [1] Yes  [2] No
echo [0] Back
echo:
choice /c 120 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 ( set "formatwz_opts=/c" & goto qf )
if !edendos_inp! EQU 2 goto qf
if !edendos_inp! EQU 3 goto fsys
goto NTFS

:UDF
echo:
echo ^(2a/5^) UDF Revision
echo -------------------
echo [1] 1.02  [2] 1.50  [3] 2.00  [4] 2.01 (default)  [5] 2.50
echo [0] Back
echo:
choice /c 123450 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 ( set "formatwz_opts=/r:1.02" & goto qf )
if !edendos_inp! EQU 2 ( set "formatwz_opts=/r:1.50" & goto qf )
if !edendos_inp! EQU 3 ( set "formatwz_opts=/r:2.00" & goto qf )
if !edendos_inp! EQU 4 ( set "formatwz_opts=/r:2.01" & goto qf )
if !edendos_inp! EQU 6 goto fsys
if !edendos_inp! EQU 5 set formatwz_opts=/r:2.50
echo:
echo ^(2b/5^) Duplicate metadata?  [1] Yes  [2] No
echo [0] Back
echo:
choice /c 120 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 ( set "formatwz_opts=!formatwz_opts! /d" & goto qf )
if !edendos_inp! EQU 2 goto qf
if !edendos_inp! EQU 3 goto fsys
goto UDF

:ReFS
echo:
echo ^(2a/5^) ReFS integrity?  [1] Yes  [2] No
echo [0] Back
echo:
choice /c 120 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 ( set "formatwz_opts=/i:enable"  & goto qf )
if !edendos_inp! EQU 2 ( set "formatwz_opts=/i:disable" & goto qf )
if !edendos_inp! EQU 3 goto fsys
goto ReFS

:qf
echo:
echo ^(3/5^) Quick format?  [1] Yes  [2] No
echo [0] Back
echo:
choice /c 120 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 ( set "formatwz_mode=/q" & goto label )
if !edendos_inp! EQU 2 goto wipe
if !edendos_inp! EQU 3 goto fsys
goto qf

:wipe
echo:
echo ^(3a/5^) Wipe Volume
echo ------------------
echo [1] Once  [2] Twice  [3] Thrice  [4] Four times  [5] Five times
echo [6] Six times  [7] Seven times  [8] Eight times  [9] Nine times
echo [0] Back
echo:
choice /c 1234567890 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 ( set "formatwz_mode=/p:0" & goto label )
if !edendos_inp! EQU 2 ( set "formatwz_mode=/p:1" & goto label )
if !edendos_inp! EQU 3 ( set "formatwz_mode=/p:2" & goto label )
if !edendos_inp! EQU 4 ( set "formatwz_mode=/p:3" & goto label )
if !edendos_inp! EQU 5 ( set "formatwz_mode=/p:4" & goto label )
if !edendos_inp! EQU 6 ( set "formatwz_mode=/p:5" & goto label )
if !edendos_inp! EQU 7 ( set "formatwz_mode=/p:6" & goto label )
if !edendos_inp! EQU 8 ( set "formatwz_mode=/p:7" & goto label )
if !edendos_inp! EQU 9 ( set "formatwz_mode=/p:8" & goto label )
if !edendos_inp! EQU 10 goto qf
goto wipe

:label
echo:
set formatwz_labl=
set /p formatwz_labl="(4/5) Input new volume label: "

:format
echo:
echo      Volume: !formatwz_volm!:
echo File system: !formatwz_fsys!
echo     Options: !formatwz_opts!
echo        Mode: !formatwz_mode!
echo       Label: !formatwz_labl!
echo:
echo ^(5/5^) Are the parameters correct?  [1] Yes  [2] No, start over
echo [0] Back
echo:
choice /c 120 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 2 goto volm
if !edendos_inp! EQU 3 goto qf
echo:
echo:
cd\
vol !formatwz_volm!:
echo:
format !formatwz_volm!: /fs:!formatwz_fsys! !formatwz_opts! !formatwz_mode! /v:!formatwz_labl! /x
set edendos_err=!errorlevel!
echo:
echo:

if !edendos_err! EQU 0 (
    echo ^<format/i^> The format operation was successful
    goto end
)

if !edendos_err! EQU 1 (
    echo ^<format/X^> Incorrect parameters were supplied
    goto fail
)

if !edendos_err! EQU 4 (
    echo ^<format/X^> A fatal error occurred
    goto fail
)

:fail
echo:
echo The operation was not successful. What now?  [1] Retry  [2] Start over  [3] End
echo:
choice /c 123 /n /cs /m "<formatwz/_> Input: "
set edendos_inp=!errorlevel!
if !edendos_inp! EQU 1 goto format
if !edendos_inp! EQU 2 goto volm
cd /d !edendosd!
endlocal
goto end