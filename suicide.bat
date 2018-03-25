@echo off
cd /d %~dp0

rem batを配置したディレクトリを自分のバッチファイルごと削除
rem カレントディレクトリの削除はできないため、予め一階層上に戻る
cd ../ 
rmdir /s %~dp0