@echo off

:: 查找本机ip
ipconfig ^ | findstr "IPv4" > ipadd.txt
for /f "tokens=2 delims=:" %%i in (ipadd.txt) do set ipstr=%%i
for /f "tokens=1 delims= " %%i in ('echo %ipstr%') do set ip=%%i
del ipadd.txt 

:: 启动 erlang
set cookie=abc
set node=node@%ip%
@REM start werl +K true +sbt db +sub true -setcookie %cookie% -name %node% 
start werl +K true +sbt db +sub true -setcookie %cookie% -name %node% 
pause
exit