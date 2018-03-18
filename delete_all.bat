@echo off

rem バッチを配置したディレクトリに移動する

setlocal enabledelayedexpansion
rem %1 isRoot : バッチを配置したディレクトリかの判定を行う
rem %2 対象ディレクトリ : 対象となるディレクトリ

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

cd !targetDir!

rem ディレクトリを発見した場合は新規にバッチを実行する
for /F  "delims=:" %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    if exist %%A\ (
        echo "this "%%A" is directory"
        call %~dpnx0 0 !CD!\%%A
        if "%2"=="" (
            cd "%~dp0"
        ) else (
            cd %2
        )
    )
)

rem 仮想ドライブにディレクトリをマウントする
subst X: "!targetDir!"
subst

rem batを配置したディレクトリを自分のバッチファイルごと削除
X:

echo !CD!
rem デフォルトでは半角スペースの区切り文字をコロンに変更する

set /a count=0

for /F  "delims=:" %%A in ('dir /B') do (  
    set /a count=!count!+1
)
echo !count!

if not !count!==0 (
    call :end_point
)

for /F  "delims=:" %%A in ('dir /B') do (
    pause  
    echo X:\%%A

    if not exist %%A\ (
        rem バッチファイル自身出ない場合のみ削除
        if not "%%A"=="%~nx0" (
            echo "delete file"
            echo "this "%%A" is file"
            pause
            del /Q X:\%%A
        ) else (
            echo "this batch"
        )
    ) else (
        echo "delet directory"
        echo "this "%%A" is directory"
        pause
        rd X:\%%A
    )
)

:end_point
echo "end_point"

rem マウントを解除する
subst /D X:

rem 元のディレクトリに戻る
echo !targetDir!
cd !targetDir!

pause

rem 自分自身を削除する(isRootの場合のみ)
if !isRoot!==1 (
    echo "delete own directory"
    !CD!
    pause
    cd ../ 
    rem rmdir /s /q "%~dp0"
)

endlocal