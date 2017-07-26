docker-compose up -d

@echo off
rem Wait for application to startup (ping during 30 seconds, waiting 1 second each time)
set count=0
set maxcount=30

echo Wait until service is available
:loop
if /i %count% geq %maxcount% goto :timeout

curl -sI --url http://localhost:8080/health

if /i %ERRORLEVEL% NEQ 0 goto :retry
goto :up

:retry
set /a "count+=1"
echo|set /p="."
sleep 1
goto :loop

goto :up

:timeout
echo Timeout expired
goto :end

:up
echo Service is available.

:end
