@echo off

echo [+] Finding public IP...

:: Find public IP
for /f "tokens=* delims= " %%a in ('curl -s -4 ifconfig.me') do set dest=%%a

if not defined dest (
    echo [-] ERROR: Could not fetch public IP.
    exit /b 1
)

echo [+] Found: %dest%

echo [+] Performing tracert...

:: Perform a tracert and extract the first hop's destination IP
FOR /F "tokens=1,8,9 delims= " %%A IN ('tracert /d /h 1 %Dest%') DO IF %%A GEQ 1 IF %%A LEQ 1 ( set hop=%%B )

if not defined hop (
    echo [-] ERROR: Could not extract the first hop from the tracert.
    exit /b 1
)

echo [+] First Hop: %hop%

:: Compare the public IP to the first hop of the tracert. If they are the same, most likely no CGNAT! else BAD!
call :Comparator %dest% %hop%
echo: 

:: Return result of test
if %retVal%==1 (
   echo [+] GOOD NEWS! You appear to NOT be behind a CGNAT!
) else (
   echo [-] BAD NEWS: You may be behind a CGNAT!
)

:Comparator
:: Perform comparison of public IP and first hop and  return 1 or 0
if "%~1" == "%~2" (set retVal=1) else (set retVal=0)
goto :eof
