@echo off
cd /d %~dp0

setlocal enabledelayedexpansion
set move_to="moveTo"
for /F %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    echo !name!

    rem ファイル名にダブルクオーテーションをつけることでファイル名の一致を判断
    echo !move_to!
    if  "!name!" == "%~nx0" (
        echo "this is used bat"
    ) else if  "!name!" == !move_to! (
        rem 文字列の変数に対してはダブルクオーテーションが必要
        echo "this is to direcoty"
    ) else (
        echo "this is target file"
        move !name! !move_to! 
    )
)  
endlocal

pause