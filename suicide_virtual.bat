@echo off
cd /d %~dp0

setlocal enabledelayedexpansion
rem 仮想ドライブにディレクトリをマウントする
subst X: "!CD!"

rem batを配置したディレクトリを自分のバッチファイルごと削除
cd X:

rem デフォルトでは半角スペースの区切り文字をコロンに変更する    
for /F  "delims=:" %%A in ('dir /B') do (  
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    echo X:\!name!
    if not exist !name!\ (
        rem バッチファイル自身出ない場合のみ削除
        if not "!name!"=="%~nx0" (
            echo "this is file"
            del /Q "X:\!name!"
        ) else (
            echo "this batch"
        )
    ) else (
        echo "this is directory"
        rd "X:\!name!"
    )
)

rem マウントを解除する
subst /D X:

rem ディレクトリを元(バッチを配置した所)
cd /d %~dp0
echo !CD!

rem 自分自身を削除する
echo "delete own directory"
pause
cd ../ 
rmdir /s /q "%~dp0"

endlocal