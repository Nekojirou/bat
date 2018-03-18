@echo off
cd /d %~dp0

setlocal enabledelayedexpansion
for /F %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    echo !name!

    rem ファイル名に\をつけることでfileかディレクトリかを判定
    if not exist !name!\ (
        echo "this is file"
    ) else (
        echo "this is directory"
    )
)  
endlocal

pause