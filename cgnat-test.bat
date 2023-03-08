@echo off

echo Finding public IP...

:: Find public IP using powershell Invoke-WebRequest cmdlet
for /f "tokens=* delims= " %%a in ('powershell -command "(Invoke-WebRequest ifconfig.me).Content.Trim()" ') do set "dest=%%a"
echo ^>^> Found: %dest%

echo Performing tracert...

:: Perform a tracert and extract the first hop's destination IP
FOR /F "tokens=1,8,9 delims= " %%A IN ('tracert /d /h 1 %Dest%') DO IF %%A GEQ 1 IF %%A LEQ 1 ( set hop=%%B )
echo ^>^> First Hop: %hop%

:: Compare the public IP to the first hop of the tracert. If they are the same, most likely no CGNAT! else BAD!
call :Comparator %dest% %hop%
echo: 

:: Return result of test
if %retVal%==1 (
   echo GOOD NEWS! You appear to NOT be behind a CGNAT!
) else (
   echo BAD NEWS: You may be behind a CGNAT!
)

:Comparator
:: Perform comparison of public IP and first hop and  return 1 or 0
if "%~1" == "%~2" (set retVal=1) else (set retVal=0)
goto :eof