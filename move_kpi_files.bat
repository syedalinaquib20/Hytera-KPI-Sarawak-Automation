@echo off
setlocal enabledelayedexpansion

set "SOURCE_DIR=C:\IPNM\NEM-530\kpi-csv"
set "TARGET_DIR=C:\RRD\kpi-latest-month"

echo Start
echo.

if not exist "%SOURCE_DIR%\" (
    echo Source folder not found: "%SOURCE_DIR%"
    exit /b 1
)

if not exist "%TARGET_DIR%\" (
    echo Target folder not found: "%TARGET_DIR%"
    exit /b 1
)

echo CSV files in "%SOURCE_DIR%":
dir /b /a-d "%SOURCE_DIR%\*.csv"
echo.

set "FILES_FOUND="
for /f "delims=" %%F in ('dir /b /a-d "%SOURCE_DIR%\*.csv" 2^>nul') do (
    set "FILES_FOUND=1"
    move "%SOURCE_DIR%\%%F" "%TARGET_DIR%\" >nul
    if errorlevel 1 (
        echo Failed to move file: %%F
        exit /b 1
    )
)

if not defined FILES_FOUND (
    echo No CSV files found in "%SOURCE_DIR%".
    exit /b 0
)

echo All files have been moved successfully
exit /b 0
