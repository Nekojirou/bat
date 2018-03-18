@echo off

setlocal enabledelayedexpansion
if "%1" == "" (
    set /a isRoot=1
) else (
    set /a isRoot=%1
)
echo !isRoot!

if "%2" == "" (
    set targetDir=!CD!
) else (
    set targetDir=%2
)
echo !targetDir!

:check_directory
cd !targetDir!
rem ディレクトリを発見した場合は新規にバッチを実行する
for /F  "delims=:" %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    if exist !name!\ (
        echo "this "!name!" is directory"
        call %~dpnx0 0 !CD!\!name!
        cd !targetDir!
    )
)

rem rootの場合はpauseにする
if !isRoot!==1 (
  pause  
)

endlocal