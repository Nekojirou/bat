rem hide source
@echo off

rem "引数の有無はこの形式で確認する"
if "%1" == "" (

    set /A count=1

) else (
    rem %0にはバッチファイルの名称が入る
    echo %1
    set /A count=%1+1
)

echo %count%"'s"
pause

call %~dpnx0  %count%

pause 