# Hainager PWA & TWA Setup Guide

This guide will help you convert your React Vite project into a Progressive Web App (PWA) and generate a Trusted Web Activity (TWA) Android app using Bubblewrap.

## Prerequisites

- Node.js and npm installed
- Your React app deployed on Replit
- Android Studio (optional, for advanced customization)

## Step 1: PWA Setup (Already Completed)

✅ **PWA Manifest**: Created `client/public/manifest.json` with proper PWA configuration
✅ **Service Worker**: Created `client/public/sw.js` for offline functionality
✅ **Meta Tags**: Updated `client/index.html` with PWA meta tags
✅ **Service Worker Registration**: Added to `client/src/main.tsx`

## Step 2: Deploy Your Updated App

1. Commit and push your changes to your repository
2. Ensure your Replit app is running with the updated PWA features
3. Test your PWA by visiting your Replit URL and checking if "Add to Home Screen" appears

## Step 3: Generate TWA Android App

### Option A: Using PowerShell Script (Recommended for Windows)

1. Open PowerShell in the project directory
2. Run the script:
   ```powershell
   .\create-twa.ps1
   ```
3. Enter your Replit URL when prompted
4. The script will generate the TWA in the `hainager-twa` directory

### Option B: Manual Command Line

1. Get your Replit URL (e.g., `https://your-app-name.your-username.replit.dev`)
2. Run Bubblewrap command:
   ```bash
   bubblewrap init --manifest=https://your-replit-url.replit.dev/manifest.json --directory=hainager-twa
   ```

## Step 4: Build Your Android App

### Using Command Line (Requires Android SDK)

1. Navigate to the generated TWA directory:
   ```bash
   cd hainager-twa
   ```

2. Build the APK:
   ```bash
   ./gradlew assembleRelease
   ```

3. The APK will be generated in `app/build/outputs/apk/release/`

### Using Android Studio

1. Open Android Studio
2. Open the `hainager-twa` directory as a project
3. Build → Build Bundle(s) / APK(s) → Build APK(s)
4. The APK will be generated in `app/build/outputs/apk/debug/`

## Step 5: Customize Your App (Optional)

### App Configuration

Edit `hainager-twa/app/src/main/res/values/strings.xml` to customize:
- App name
- Package name
- Version information

### Icons and Branding

Replace icons in `hainager-twa/app/src/main/res/`:
- `mipmap-hdpi/` - 72x72px
- `mipmap-mdpi/` - 48x48px
- `mipmap-xhdpi/` - 96x96px
- `mipmap-xxhdpi/` - 144x144px
- `mipmap-xxxhdpi/` - 192x192px

### Signing Your App

For production release:

1. Generate a keystore:
   ```bash
   keytool -genkey -v -keystore hainager-release-key.keystore -alias hainager -keyalg RSA -keysize 2048 -validity 10000
   ```

2. Configure signing in `hainager-twa/app/build.gradle`

## Step 6: Testing

### PWA Testing
- Visit your Replit URL on mobile
- Check if "Add to Home Screen" option appears
- Test offline functionality
- Verify manifest.json is accessible

### TWA Testing
- Install the generated APK on an Android device
- Test app functionality
- Verify it behaves like a native app

## Troubleshooting

### Common Issues

1. **Manifest not found**: Ensure your Replit URL is correct and manifest.json is accessible
2. **Build errors**: Make sure Android SDK is properly installed
3. **PWA not working**: Check browser console for service worker errors
4. **Icons not displaying**: Verify icon paths in manifest.json

### Useful Commands

```bash
# Check if Bubblewrap is installed
bubblewrap --version

# Validate PWA
npx lighthouse https://your-replit-url.replit.dev --view

# Test service worker
# Open DevTools → Application → Service Workers
```

## Next Steps

1. **Google Play Store**: Prepare your app for Play Store submission
2. **App Store**: Consider using Capacitor for iOS support
3. **Updates**: Your TWA will automatically update when you update your web app
4. **Analytics**: Add analytics to track app usage

## Files Created

- `client/public/manifest.json` - PWA manifest
- `client/public/sw.js` - Service worker
- `twa-config.json` - TWA configuration
- `create-twa.ps1` - PowerShell script for TWA generation
- `create-twa.bat` - Batch script for TWA generation

## Support

For issues with:
- **PWA**: Check browser developer tools
- **Bubblewrap**: Visit [Bubblewrap documentation](https://github.com/GoogleChromeLabs/bubblewrap)
- **TWA**: Check [TWA documentation](https://developers.google.com/web/android/trusted-web-activity)
