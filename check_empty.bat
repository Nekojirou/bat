@echo off

setlocal enabledelayedexpansion
set /a CNT=0

for /F  "delims=:" %%A in ('dir /B') do (  
    set /a CNT=!CNT!+1
)
echo !CNT!
endlocal

pause