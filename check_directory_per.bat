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
    if exist %%A\ (
        echo "this "%%A" is directory"
        call %~dpnx0 0 !CD!\%%A
        cd %%A
    ) else (
        echo "this "%%A" is file"
    )
)

rem rootの場合はpauseにする
if !isRoot!==1 (
  pause  
)

endlocal