# SignTaxi - Quick Implementation Reference

## 🚀 **QUICK START**

### 1. **Navigate to Project Directory**
```bash
cd e:\VIGNESH\Software-Development\sign_taxi-main\sign_taxi-main
```

### 2. **Install Dependencies**
```bash
flutter pub get
```

### 3. **Run the App**
```bash
flutter run
```

---

## 📂 **FILE STRUCTURE**

```
lib/
├── main.dart ............................ ✅ UPDATED (MultiProvider)
│
├── presentation/
│   ├── common/
│   │   ├── custom_app_bar.dart ........... ✅ NEW - Fixed top app bar
│   │   └── custom_bottom_navbar.dart ..... ✅ NEW - Bottom navigation
│   │
│   ├── providers/
│   │   ├── theme_provider.dart ........... ✅ UPDATED (Modern colors)
│   │   ├── navigation_provider.dart ...... ✅ NEW - Nav state
│   │   ├── app_auth_provider.dart
│   │   └── driver_provider.dart
│   │
│   └── screens/
│       ├── passenger/
│       │   └── passenger_home_screen.dart  ✅ UPDATED (Modern redesign)
│       │
│       ├── driver/
│       │   └── driver_home_screen.dart .... ✅ UPDATED (Modern redesign)
│       │
│       ├── booking/
│       ├── common/
│       └── ...
│
├── data/
├── domain/
└── core/

assets/
└── theme.json ........................... ✅ UPDATED (Professional colors)
```

---

## 🎨 **COLOR CODES REFERENCE**

```dart
// PRIMARY COLORS
const Color primaryBlue = Color(0xFF1E3A8A);      // #1E3A8A
const Color primaryDark = Color(0xFF1E40AF);     // #1E40AF
const Color primaryLight = Color(0xFF3B82F6);    // #3B82F6

// SECONDARY COLORS
const Color secondaryTeal = Color(0xFF0891B2);   // #0891B2
const Color accentCyan = Color(0xFF06B6D4);     // #06B6D4

// BACKGROUNDS
const Color bgLight = Color(0xFFF8FAFC);         // #F8FAFC
const Color surfaceWhite = Color(0xFFFFFFFF);    // #FFFFFF

// TEXT COLORS
const Color textPrimary = Color(0xFF1E293B);     // #1E293B
const Color textSecondary = Color(0xFF64748B);   // #64748B

// STATUS COLORS
const Color successGreen = Color(0xFF10B981);    // #10B981
const Color errorRed = Color(0xFFEF4444);        // #EF4444
const Color warningOrange = Color(0xFFF59E0B);   // #F59E0B
const Color infoBlue = Color(0xFF3B82F6);        // #3B82F6
```

---

## 🧩 **COMPONENT USAGE EXAMPLES**

### **Using CustomAppBar**

```dart
import 'package:signtaxi_app/presentation/common/custom_app_bar.dart';

Scaffold(
  appBar: CustomAppBar(
    title: 'Ride History',
    backgroundColor: Colors.blue[900],
    showBackButton: true,
    onBackPressed: () => Navigator.pop(context),
    actions: [
      IconButton(
        icon: Icon(Icons.more_vert, color: Colors.white),
        onPressed: () { /* menu */ },
      ),
    ],
  ),
  body: ...,
)
```

### **Using CustomBottomNavBar**

```dart
import 'package:signtaxi_app/presentation/common/custom_bottom_navbar.dart';

class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My App'),
      body: ...,
      bottomNavigationBar: CustomBottomNavBar(
        items: [
          BottomNavItem(icon: Icons.home_filled, label: 'Home'),
          BottomNavItem(icon: Icons.history, label: 'History'),
          BottomNavItem(icon: Icons.favorite_border, label: 'Saved'),
          BottomNavItem(icon: Icons.menu, label: 'Menu'),
        ],
        currentIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation
          switch(index) {
            case 0:
              // Home
              break;
            case 1:
              // History
              break;
            case 2:
              // Saved
              break;
            case 3:
              // Menu
              break;
          }
        },
      ),
    );
  }
}
```

### **Using Theme Colors**

```dart
import 'package:provider/provider.dart';
import 'package:signtaxi_app/presentation/providers/theme_provider.dart';

class MyComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colors = themeProvider.themeMap['colors'];
    final spacing = themeProvider.themeMap['spacing'];
    
    // Convert hex color to Color object
    final primaryColor = Color(
      int.parse('FF${colors['primary'].substring(1)}', radix: 16)
    );
    final textColor = Color(
      int.parse('FF${colors['textPrimary'].substring(1)}', radix: 16)
    );

    return Container(
      color: primaryColor,
      padding: EdgeInsets.all(spacing['md']),
      child: Text(
        'Hello',
        style: TextStyle(color: textColor),
      ),
    );
  }
}
```

---

## 🛠️ **COMMON CUSTOMIZATIONS**

### **Change App Bar Title**
```dart
appBar: CustomAppBar(
  title: 'Your Custom Title',
),
```

### **Add Navigation Actions**
```dart
appBar: CustomAppBar(
  title: 'Title',
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
),
```

### **Show Back Button**
```dart
appBar: CustomAppBar(
  title: 'Back Example',
  showBackButton: true,
  onBackPressed: () => Navigator.pop(context),
),
```

### **Update Bottom Nav Items**
```dart
bottomNavigationBar: CustomBottomNavBar(
  items: [
    BottomNavItem(icon: Icons.dashboard, label: 'Dashboard'),
    BottomNavItem(icon: Icons.people, label: 'Users'),
    BottomNavItem(icon: Icons.settings, label: 'Settings'),
  ],
  currentIndex: _currentIndex,
  onItemTapped: (index) {
    setState(() => _currentIndex = index);
  },
),
```

---

## ⚙️ **CONFIGURATION FILES**

### **assets/theme.json Structure**
```json
{
  "colors": {
    "primary": "#1E3A8A",
    "secondary": "#0891B2",
    "accent": "#06B6D4",
    // ... other colors
  },
  "spacing": {
    "xs": 4,
    "sm": 8,
    "md": 16,
    "lg": 24,
    "xl": 32,
    "xxl": 48
  },
  "borderRadius": {
    "sm": 4,
    "md": 8,
    "lg": 16,
    "xl": 24
  }
}
```

### **pubspec.yaml Requirements**
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1          # State management
  firebase_core: ^2.24.2    # Firebase
  # ... other dependencies
```

---

## 🔧 **TROUBLESHOOTING**

### **Colors Not Updating?**
```dart
// 1. Ensure ThemeProvider is wrapped in MultiProvider
// 2. Clear build cache:
flutter clean
flutter pub get

// 3. Rebuild:
flutter run
```

### **Bottom Navbar Missing?**
```dart
// Ensure Scaffold has:
- bottomNavigationBar: CustomBottomNavBar(...)
// NOT only:
- floatingActionButton:
```

### **App Bar Not Fixed?**
```dart
// Ensure using:
appBar: CustomAppBar(...)
// NOT:
appBar: AppBar(...)
// CustomAppBar has proper PreferredSizeWidget implementation
```

---

## 📋 **DEPLOYMENT CHECKLIST**

- [ ] Colors updated in theme.json
- [ ] CustomAppBar used in all screens
- [ ] CustomBottomNavBar added to home screens
- [ ] Navigation logic implemented
- [ ] App tested in both portrait and landscape
- [ ] Colors verified on various devices
- [ ] Accessibility tested (text contrast, touch targets)
- [ ] Performance checked (no jank, smooth scrolling)
- [ ] Build successful: `flutter build apk` or `flutter build ios`

---

## 📚 **ADDITIONAL RESOURCES**

### **Material Design 3 Guidelines**
- Color system: https://m3.material.io/styles/color/overview
- Components: https://m3.material.io/components

### **Flutter Documentation**
- Provider: https://pub.dev/packages/provider
- Material App: https://api.flutter.dev/flutter/material/MaterialApp-class.html
- ThemeData: https://api.flutter.dev/flutter/material/ThemeData-class.html

### **Best Practices**
1. Always use theme colors from `ThemeProvider`
2. Maintain consistent spacing using spacing values
3. Use Material Design 3 components
4. Test responsive design on multiple devices
5. Keep color contrast ratios accessible (4.5:1 for text)

---

## 💡 **TIPS & TRICKS**

### **Quick Color Access Helper**
```dart
// Create a helper method in your utils
Color getThemeColor(BuildContext context, String colorName) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final colors = themeProvider.themeMap['colors'];
  return Color(
    int.parse('FF${colors[colorName].substring(1)}', radix: 16)
  );
}

// Usage:
final primaryColor = getThemeColor(context, 'primary');
```

### **Spacing Helper**
```dart
int getSpacing(BuildContext context, String sizeKey) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return themeProvider.themeMap['spacing'][sizeKey];
}

// Usage:
EdgeInsets.all(getSpacing(context, 'md'))
```

### **Quick Box Shadow**
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.08),
  blurRadius: 12,
  offset: const Offset(0, 4),
)
```

