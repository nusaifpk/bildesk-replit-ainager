# PowerShell script to create TWA for Hainager
Write-Host "Creating TWA for Hainager..." -ForegroundColor Green
Write-Host ""

# Get Replit URL from user
$replitUrl = Read-Host "Enter your Replit URL (e.g., https://your-app-name.your-username.replit.dev)"

if ([string]::IsNullOrWhiteSpace($replitUrl)) {
    Write-Host "Error: Replit URL is required!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Updating configuration with your URL..." -ForegroundColor Yellow

# Update the config file with the actual URL
$configContent = Get-Content 'twa-config.json' -Raw
$configContent = $configContent -replace 'https://your-replit-url.replit.dev', $replitUrl
Set-Content 'twa-config.json' $configContent

Write-Host ""
Write-Host "Generating TWA with Bubblewrap..." -ForegroundColor Yellow

# Generate TWA
try {
    bubblewrap init --manifest="$replitUrl/manifest.json" --directory=hainager-twa
    
    Write-Host ""
    Write-Host "TWA generation complete! Check the 'hainager-twa' directory for your Android app." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Review the generated files in 'hainager-twa'" -ForegroundColor White
    Write-Host "2. Build the APK using: cd hainager-twa && ./gradlew assembleRelease" -ForegroundColor White
    Write-Host "3. Or open the project in Android Studio for further customization" -ForegroundColor White
    Write-Host ""
    Write-Host "Your TWA is ready! The Android project is located in the 'hainager-twa' directory." -ForegroundColor Green
} catch {
    Write-Host "Error generating TWA: $_" -ForegroundColor Red
    Write-Host "Make sure your Replit URL is accessible and the manifest.json is available." -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Press Enter to continue..."
