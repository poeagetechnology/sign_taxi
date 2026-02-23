@echo off
REM SignTaxi Build Script for Windows
REM This script helps you quickly build APK and Web versions

setlocal enabledelayedexpansion

echo.
echo ========================================
echo    SignTaxi - Build Helper
echo ========================================
echo.
echo 1. Build Debug APK (for testing)
echo 2. Build Release APK (for production)
echo 3. Run on Android Device
echo 4. Run Web (Chrome)
echo 5. Build Web for Production
echo 6. Clean Project
echo 7. Exit
echo.
set /p choice="Enter your choice (1-7): "

cd /d "%~dp0"

if "%choice%"=="1" (
    echo.
    echo Building Debug APK...
    flutter build apk --debug
    echo.
    echo APK saved to: build\app\outputs\apk\debug\app-debug.apk
    pause
) else if "%choice%"=="2" (
    echo.
    echo Building Release APK...
    flutter build apk --release
    echo.
    echo APK saved to: build\app\outputs\apk\release\app-release.apk
    pause
) else if "%choice%"=="3" (
    echo.
    echo Running on connected device...
    flutter run
    pause
) else if "%choice%"=="4" (
    echo.
    echo Starting Web App on Chrome...
    flutter run -d chrome
    pause
) else if "%choice%"=="5" (
    echo.
    echo Building Web App for Production...
    flutter build web --release
    echo.
    echo Web app saved to: build\web\
    pause
) else if "%choice%"=="6" (
    echo.
    echo Cleaning project...
    flutter clean
    flutter pub get
    echo. 
    echo Project cleaned!
    pause
) else if "%choice%"=="7" (
    exit /b
) else (
    echo Invalid choice!
    pause
    goto :start
)
