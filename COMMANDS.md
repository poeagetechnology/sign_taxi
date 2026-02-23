# SignTaxi - Quick Command Reference

## Most Used Commands

### 🔨 Building

**Build Debug APK (Fast, for testing)**
```bash
flutter build apk --debug
```
Output: `build/app/outputs/apk/debug/app-debug.apk`

**Build Release APK (Optimized, for distribution)**
```bash
flutter build apk --release
```
Output: `build/app/outputs/apk/release/app-release.apk`

**Build Web Production**
```bash
flutter build web --release
```
Output: `build/web/`

### 📱 Running

**Run on Physical Device (USB Connected)**
```bash
flutter run
```

**Run on Emulator**
```bash
flutter run -d chrome    # Web browser
flutter run             # Android emulator (if running)
```

**Run Web Development**
```bash
flutter run -d chrome
flutter run -d firefox
flutter run -d edge
```

### 🧹 Cleaning

**Clean Build Cache**
```bash
flutter clean
```

**Get Dependencies**
```bash
flutter pub get
```

**Full Reset**
```bash
flutter clean && flutter pub get
```

### 🔍 Debugging

**Check Setup**
```bash
flutter doctor
flutter doctor -v
```

**Code Analysis**
```bash
flutter analyze
```

**Format Code**
```bash
flutter format lib/
```

**Run Tests**
```bash
flutter test
```

### 📦 Advanced

**Split APKs (Smaller for different architectures)**
```bash
flutter build apk --split-per-abi --release
```

**App Bundle (For Google Play)**
```bash
flutter build appbundle --release
```

**Build All Platforms**
```bash
flutter build web --release
flutter build apk --release
```

### 🌐 Web Deployment

**After building web with `flutter build web --release`**

Upload `build/web/` folder to:
- **Firebase:** `firebase deploy`
- **Vercel:** Drag & drop `build/web` folder
- **Netlify:** Drag & drop `build/web` folder

### 🔑 One-Liners

| Task | Command |
|------|---------|
| Setup & Build APK | `flutter clean && flutter pub get && flutter build apk --release` |
| Quick Test | `flutter run` |
| Get Latest Deps | `flutter pub upgrade` |
| Check for Updates | `flutter pub outdated` |
| Fix Issues | `flutter pub cache repair` |

### 🎯 Workflow

**New Setup:**
```bash
flutter pub get           # Get dependencies
flutter analyze          # Check for errors
flutter run              # Test on device
```

**Build for Release:**
```bash
flutter clean
flutter pub get
flutter build apk --release
```

**Deploy to Play Store:**
```bash
flutter build appbundle --release
# Upload build/app/outputs/bundle/release/app-release.aab to Google Play Console
```

---

**💾 Saved APK Location after build:**
- Debug: `build/app/outputs/apk/debug/app-debug.apk`
- Release: `build/app/outputs/apk/release/app-release.apk`

**⏱️ Build Times (Approximate):**
- Debug APK: 2-3 minutes (first time: 5-10 min)
- Release APK: 3-5 minutes
- Web Build: 1-2 minutes

**📍 For more details, see BUILD_GUIDE.md**
