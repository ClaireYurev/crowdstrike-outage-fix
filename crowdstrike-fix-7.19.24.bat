@echo off

:: Enable command extensions
setlocal enableextensions

:: Set the file path variable
set "FILE_PATH=C:\Windows\System32\drivers\CrowdStrike\C-00000291*.sys"

:: Check if channel file 291 exists and delete it
if exist %FILE_PATH% (
    echo Deleting %FILE_PATH%
    del /f /q %FILE_PATH%
    echo File deleted successfully.
) else (
    echo File not found: %FILE_PATH%
)

:: End script
endlocal
echo Script completed.
pause
