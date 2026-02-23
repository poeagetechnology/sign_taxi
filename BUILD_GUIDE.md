# SignTaxi Build & Deployment Guide

This guide explains how to build and run SignTaxi for both Android APK and Web platforms.

## Prerequisites

1. **Flutter SDK** - Download from [flutter.dev](https://flutter.dev)
2. **Android Studio** or **Android SDK** (for APK builds)
3. **Java Development Kit (JDK)** - Version 17 or later
4. Good internet connection for downloading dependencies

## Project Setup

### 1. Install Dependencies

```bash
cd c:\signtaxi_app
flutter pub get
```

### 2. Enable Web Support (if not already enabled)

```bash
flutter config --enable-web
```

### 3. Remove build cache (if needed)

```bash
flutter clean
flutter pub get
```

## Building for Android (APK)

### Method 1: Debug APK (for testing)

```bash
cd c:\signtaxi_app
flutter build apk --debug
```

**Output Location:** `build/app/outputs/apk/debug/app-debug.apk`

### Method 2: Release APK (for production/distribution)

```bash
cd c:\signtaxi_app
flutter build apk --release
```

**Output Location:** `build/app/outputs/apk/release/app-release.apk`

### Method 3: Split APKs (for smaller file size)

```bash
cd c:\signtaxi_app
flutter build apk --split-per-abi --release
```

**Output Locations:** 
- `build/app/outputs/apk/release/app-arm64-v8a-release.apk`
- `build/app/outputs/apk/release/app-armeabi-v7a-release.apk`
- `build/app/outputs/apk/release/app-x86_64-release.apk`

## Running on Android Device

### Using Connected Physical Device

1. Connect your Android device via USB
2. Enable USB Debugging on your device
3. Run:

```bash
flutter run
```

### Using Emulator

1. Open Android Studio
2. Create/start an Android Virtual Device (AVD)
3. Run:

```bash
flutter run
```

## Building for Web

### Development Server (Hot reload enabled)

```bash
cd c:\signtaxi_app
flutter run -d chrome
```

Or for Firefox:
```bash
flutter run -d firefox
```

### Production Web Build

```bash
cd c:\signtaxi_app
flutter build web --release
```

**Output Location:** `build/web/`

### Deploy Web App

After building, deploy the contents of `build/web/` to your web server (Firebase Hosting, Netlify, Vercel, etc.)

## Troubleshooting

### Issue: "ANDROID_SDK_ROOT not set"
**Solution:**
```bash
# Set the Android SDK path (replace with your actual path)
$env:ANDROID_SDK_ROOT = "C:\Users\YourUsername\AppData\Local\Android\Sdk"
```

### Issue: "Gradle build failed"
**Solution:**
```bash
flutter clean
flutter pub get
flutter pub cache repair
```

### Issue: WebView not working on APK
**Ensure:** 
- Internet permission is added in `AndroidManifest.xml` ✓
- Use `WebViewController` with proper initialization
- Test on a device with Google Play Services

## Project Configuration

- **App Name:** SignTaxi
- **Package Name:** com.signtaxi.app
- **Web URL:** https://www.redtaxi.co.in
- **Min Android SDK:** 21
- **Target Android SDK:** 34

## For Release on Google Play Store

1. Create a key signing certificate
2. Update `android/app/build.gradle.kts` with signing config
3. Build release APK or AAB:

```bash
flutter build appbundle --release
```

## Testing Checklist

- [ ] App runs on debug APK
- [ ] webview loads redtaxi.co.in successfully
- [ ] Internet connectivity works
- [ ] App responds to back navigation
- [ ] Web build loads without errors

## Need Help?

- Flutter Docs: https://flutter.dev/docs
- WebView Plugin: https://pub.dev/packages/webview_flutter
- Android Development: https://developer.android.com
