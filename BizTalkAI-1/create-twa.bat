@echo off
echo Creating TWA for Hainager...
echo.
echo Please provide your Replit URL (default: https://bildesk-replit-ainager-ainager041.replit.app)
set /p REPLIT_URL="Enter your Replit URL (or press Enter for default): "
if "%REPLIT_URL%"=="" set REPLIT_URL=https://bildesk-replit-ainager-ainager041.replit.app

echo.
echo Updating configuration with your URL...
powershell -Command "(Get-Content 'twa-config.json') -replace 'https://your-replit-url.replit.dev', '%REPLIT_URL%' | Set-Content 'twa-config.json'"

echo.
echo Generating TWA with Bubblewrap...
bubblewrap init --manifest=%REPLIT_URL%/manifest.json --directory=hainager-twa

echo.
echo TWA generation complete! Check the 'hainager-twa' directory for your Android app.
echo.
echo Next steps:
echo 1. Review the generated files in 'hainager-twa'
echo 2. Build the APK using: cd hainager-twa && ./gradlew assembleRelease
echo 3. Or open the project in Android Studio for further customization
echo.
pause
