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

:delete_directory
rem 仮想ドライブにディレクトリをマウントする
subst X: "!targetDir!"

rem batを配置したディレクトリを自分のバッチファイルごと削除
cd X:

rem デフォルトでは半角スペースの区切り文字をコロンに変更する    
for /F  "delims=:" %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    echo "X:\!name!"
    if not exist !name!\ (
        rem バッチファイル自身出ない場合のみ削除
        if not "!name!"=="%~nx0" (
            echo "this "!name!" is file"
            del /Q "X:\!name!"
        ) else (
            echo "this batch"
        )
    ) else (
        echo "this "!name!" is directory"
        rd "X:\!name!"
    )
)

rem マウントを解除する
subst /D X:

pause

endlocal