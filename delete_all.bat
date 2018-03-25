@echo off
chcp 65001

rem バッチを配置したディレクトリに移動する

setlocal enabledelayedexpansion
rem %1 isRoot : バッチを配置したディレクトリかの判定を行う
rem %2 対象ディレクトリ : 対象となるディレクトリ

if "%1" == "" (
    set /a isRoot=1
) else (
    set /a isRoot=%1
)

if "%2" == "" (
    set targetDir=!CD!
) else (
    set targetDir=%2
)
cd !targetDir!

rem ディレクトリを発見した場合は新規にバッチを実行する
for /F  "delims=:" %%A in ('dir /B') do (  
    rem =の両脇のスペースは削除。エラーの原因になる
    if exist %%A\ (
        echo "this "%%A" is directory"
        call %~dpnx0 0 !CD!\%%A
        if !isRoot!==1 (
            rem callが終了になると勝手に元のディレクトリに戻る？
            cd %~dp0
        ) else (
            cd %2
        )
    )
)

rem 仮想ドライブにディレクトリをマウントする
subst X: !targetDir!
subst

rem batを配置したディレクトリを自分のバッチファイルごと削除
echo "move directory to genocide"
X:
echo !CD!
echo "delete targets"

rem 空ディレクトリの場合は:end_pointに移動する
set /a count=0

for /F  "delims=:" %%A in ('dir /B') do (  
    set /a count=!count!+1
)
echo !count!

if !count!==0 (
    echo "this ridectory is empty"
    call :end_point
)

for /F  "delims=:" %%A in ('dir /B') do (
    if not exist %%A\ (
        rem バッチファイル自身出ない場合のみ削除
        if not "%%A"=="%~nx0" (
            echo "delete file"
            del /Q !CD!%%A
        ) else (
            echo "this is batch"
            pause
        )
    ) else (
        echo "delete directory"
        echo !CD!%%A
    )
)

:end_point
echo "end_point"

rem 元のディレクトリに戻る
C:
subst /D X:
cd !targetDir!

rem 自分自身を削除する(isRootの場合のみ)
if !isRoot!==1 (
    echo "delete own directory"
    !CD!
    pause
    cd ../ 
    rmdir /s /q "%~dp0"
)

endlocal