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
        if !isRoot!==1 (
            rem callが終了になると勝手に元のディレクトリに戻る？
            echo "this is Root directory"
            echo !CD!
            cd %~dp0
            echo !CD!
        ) else (
            echo "this is Sub directory"
            echo !CD!            
            cd %2
            echo !CD!
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
    pause
)

for /F  "delims=:" %%A in ('dir /B') do (
        if !isRoot!==1 (
            rem ROOTディレクトリにおける削除処理？
            echo "delete on ROOT DIRECTORY"
            pause
        )     
    if not exist %%A\ (
        rem バッチファイル自身出ない場合のみ削除
        if !isRoot!==1 (
            echo "this is root directory"
            pause
        )

        if not "%%A"=="%~nx0" (
            echo "delete file"
            echo !CD!%%A
            del /Q !CD!%%A
        ) else (
            echo "this is batch"
            pause
        )
    ) else (
        echo "delete directory"
        echo !CD!%%A
        rd !CD\!%%A
    )
)

:end_point
echo "end_point"

rem 元のディレクトリに戻る
echo "now directory"
echo !CD!
echo "Return to"
echo !targetDir!
echo "change drive to C"
C:
echo !CD!
echo "release X drive"
subst /D X:
echo "change directory"
cd !targetDir!
echo "end directory"
echo !CD!
pause

rem 自分自身を削除する(isRootの場合のみ)
if !isRoot!==1 (
    echo "delete own directory"
    !CD!
    pause
    cd ../ 
    rmdir /s /q "%~dp0"
)

endlocal