@echo off
cd /d %~dp0

setlocal enabledelayedexpansion
set firstDir=!CD!
set callDir=!CD!
:explore
echo "this is callback"
rem now_directoryに移動。おそらく再帰処理する上で必要
for /F %%A in ('dir /B') do ( 
    echo !CD!
    rem echo fullpath
    rem =の両脇のスペースは削除。エラーの原因になる
    set name=%%A
    echo !name!

    rem ファイル名に\をつけることでfileかディレクトリかを判定
    if not exist !name!\ (
        echo "this is file"
    ) else (
        echo "this is directory"
        set oldDir=!CD!
        set callDir=!CD!\!name!
        echo !callDir!
        cd !callDir!
        rem for loop実行中にcdをカマスことはできないよう→変数を持たせて処理を実行させる必要 or 再帰処理専用の奴を作成する必要がある?
        call :callback
    )
)  

echo !oldDir!
rem このタイミングでカレントディレクトリに戻る必要はあるのか？
set callDir=!oldDir!


if !callDir! == !firstDir! (
    pause
) else (
    rem ここで再帰処理をいったんぶちぎる必要がある
    exit /b
)

:callback
cd !callDir!
for /F %%A in ('dir /B') do ( 
    set name=%%A
    echo !name!
)
exit /b

endlocal