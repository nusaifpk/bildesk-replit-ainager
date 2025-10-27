# Android App Creation Guide - Hainager

This guide will help you convert your Hainager web app into an Android app with URL hiding using Trusted Web Activity (TWA).

## Prerequisites

Before starting, ensure you have:

1. **Node.js** (v16 or higher) - [Download here](https://nodejs.org/)
2. **Java Development Kit (JDK)** (v11 or higher) - [Download here](https://adoptium.net/)
3. **Android Studio** (optional but recommended) - [Download here](https://developer.android.com/studio)
4. **Bubblewrap CLI** - We'll install this in Step 2

## Step 1: Verify Your Web App

First, make sure your web app is working correctly at your Replit URL:

1. Visit: https://bildesk-replit-ainager-ainager041.replit.app
2. Test all functionality (search, voice features, etc.)
3. Check that the manifest.json is accessible: https://bildesk-replit-ainager-ainager041.replit.app/manifest.json
4. Verify icons are loading: https://bildesk-replit-ainager-ainager041.replit.app/icon-512x512.png

## Step 2: Install Bubblewrap

Bubblewrap is Google's tool for creating Trusted Web Activities (TWA) from PWAs.

### Windows (PowerShell):
```powershell
# Install Bubblewrap globally
npm install -g @bubblewrap/cli

# Verify installation
bubblewrap --version
```

### Alternative (if npm install fails):
```powershell
# Install using npx (no global installation needed)
npx @bubblewrap/cli --version
```

## Step 3: Generate Android App

### Option A: Using the Updated Script (Recommended)

1. Open PowerShell in your project directory (`BizTalkAI-1`)
2. Run the script:
   ```powershell
   .\create-twa.ps1
   ```
3. When prompted for URL, press Enter to use the default (your Replit URL)
4. The script will automatically update the configuration and generate the TWA

### Option B: Manual Command

1. Open PowerShell in your project directory
2. Run this command:
   ```powershell
   npx @bubblewrap/cli init --manifest=https://bildesk-replit-ainager-ainager041.replit.app/manifest.json --directory=hainager-twa
   ```

## Step 4: Build Your Android App

### Method 1: Using Command Line (Requires Android SDK)

1. **Install Android SDK** (if not already installed):
   - Download Android Studio
   - During installation, make sure to install Android SDK
   - Add Android SDK to your PATH environment variable

2. **Navigate to the TWA directory**:
   ```powershell
   cd hainager-twa
   ```

3. **Build the APK**:
   ```powershell
   .\gradlew assembleRelease
   ```

4. **Find your APK**:
   - Location: `hainager-twa\app\build\outputs\apk\release\`
   - File: `app-release.apk`

### Method 2: Using Android Studio (Easier)

1. **Open Android Studio**
2. **Open Project**: Select the `hainager-twa` folder
3. **Wait for Gradle sync** to complete
4. **Build APK**:
   - Go to `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)`
   - Wait for build to complete
5. **Find your APK**:
   - Location: `hainager-twa\app\build\outputs\apk\debug\`
   - File: `app-debug.apk`

## Step 5: Install and Test Your App

### Install on Android Device

1. **Enable Developer Options** on your Android device:
   - Go to `Settings` → `About Phone`
   - Tap `Build Number` 7 times
   - Go back to `Settings` → `Developer Options`
   - Enable `USB Debugging`

2. **Install the APK**:
   - Transfer the APK file to your device
   - Open file manager and tap the APK
   - Allow installation from unknown sources if prompted
   - Install the app

3. **Test the app**:
   - Open the Hainager app
   - Test all features (search, voice, etc.)
   - Verify it behaves like a native app

## Step 6: Customize Your App (Optional)

### App Icons and Branding

1. **Replace app icons** in `hainager-twa\app\src\main\res\`:
   - `mipmap-hdpi\` (72x72px)
   - `mipmap-mdpi\` (48x48px)
   - `mipmap-xhdpi\` (96x96px)
   - `mipmap-xxhdpi\` (144x144px)
   - `mipmap-xxxhdpi\` (192x192px)

2. **Update app name** in `hainager-twa\app\src\main\res\values\strings.xml`:
   ```xml
   <string name="app_name">Hainager</string>
   ```

### App Configuration

Edit `hainager-twa\app\src\main\AndroidManifest.xml` for advanced settings:
- Package name
- Permissions
- App version

## Step 7: Sign Your App for Release

### Generate Keystore (For Production)

1. **Create a keystore**:
   ```powershell
   keytool -genkey -v -keystore hainager-release-key.keystore -alias hainager -keyalg RSA -keysize 2048 -validity 10000
   ```

2. **Configure signing** in `hainager-twa\app\build.gradle`:
   ```gradle
   android {
       signingConfigs {
           release {
               storeFile file('../../hainager-release-key.keystore')
               storePassword 'your-store-password'
               keyAlias 'hainager'
               keyPassword 'your-key-password'
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
   }
   ```

## Troubleshooting

### Common Issues and Solutions

1. **"Bubblewrap not found"**:
   ```powershell
   npm install -g @bubblewrap/cli
   ```

2. **"Gradle build failed"**:
   - Make sure Java JDK is installed and in PATH
   - Try: `.\gradlew clean` then `.\gradlew assembleRelease`

3. **"Manifest not found"**:
   - Verify your Replit URL is accessible
   - Check: https://bildesk-replit-ainager-ainager041.replit.app/manifest.json

4. **"App crashes on startup"**:
   - Check Android device logs in Android Studio
   - Ensure your web app is working properly

5. **"Icons not showing"**:
   - Verify icon URLs in manifest.json
   - Check: https://bildesk-replit-ainager-ainager041.replit.app/icon-512x512.png

### Useful Commands

```powershell
# Check Bubblewrap version
bubblewrap --version

# Clean and rebuild
cd hainager-twa
.\gradlew clean
.\gradlew assembleRelease

# Check Android SDK
adb version

# Install APK on connected device
adb install app\build\outputs\apk\release\app-release.apk
```

## What You Get

After following this guide, you'll have:

✅ **Android APK** that runs your web app as a native app
✅ **URL hiding** - users won't see the web URL
✅ **App icon** on home screen
✅ **Full-screen experience** without browser UI
✅ **Offline capability** (if your PWA supports it)
✅ **Push notifications** (if configured)

## Next Steps

1. **Test thoroughly** on different Android devices
2. **Upload to Google Play Store** (if desired)
3. **Set up app updates** - your TWA will automatically update when you update your web app
4. **Add analytics** to track app usage
5. **Consider iOS version** using Capacitor or similar tools

## Files Created

- `hainager-twa/` - Complete Android project
- `app-release.apk` - Your installable Android app
- Updated configuration files with your Replit URL

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Verify your web app is working at the Replit URL
3. Check Android device logs for specific error messages
4. Ensure all prerequisites are properly installed

Your Hainager app is now ready to be distributed as a native Android app! 🚀
