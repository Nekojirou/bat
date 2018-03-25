@echo off
cd /d %~dp0

%%%%%%%%%

1. バッチ実行を開始する。
2. バッチ実行開始時に対象のディレクトリを探索しる
3. 
4. 
5. 



%%%%%%%%%%






rem 引数無しの場合は最初に実行されたバッチと判断
if "%1" == "" (
    set targetDir=%CD%

     mkdir moveTo
    set toDir=%CD%\moveTo

     set /a counter=0

     set /a originFlg=1


) else (
    set targetDir=%1
    
    set toDir=%2

    set /a counter=%3+1        

    set /a originFlg=0
)

setlocal enabledelayedexpansion
set firstDir=!CD!
set callDir=!CD!
:explore
echo "this is callback"
rem now_directoryに移動。おそらく再帰処理する上で必要
for /F %%A in ('dir /B ') do ( 
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
        call callback関数
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