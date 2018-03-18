@echo off
cd /d %~dp0

setlocal enabledelayedexpansion
for /F %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    echo !name!

    rem ファイル名にダブルクオーテーションをつけることでファイル名の一致を判断
    if  "!name!" == "%~nx0" (
        echo "this is used bat"
    ) else (
        echo "this is not used bat "
    )
)  
endlocal

pause