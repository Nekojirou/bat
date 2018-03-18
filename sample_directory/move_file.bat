@echo off
cd /d %~dp0

setlocal enabledelayedexpansion
for /F %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    echo !name!

    rem ファイル名にダブルクオーテーションをつけることでファイル名の一致を判断

)  
endlocal

pause