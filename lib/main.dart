import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/navigation_provider.dart';
import 'presentation/screens/landing_page.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/role_selection_screen.dart';
import 'presentation/screens/passenger/passenger_home_screen.dart';
import 'presentation/screens/driver/driver_home_screen.dart';
import 'presentation/screens/booking/searching_screen.dart';
import 'presentation/screens/booking/driver_assigned_screen.dart';
import 'presentation/screens/booking/ride_progress_screen.dart';
import 'presentation/screens/booking/payment_screen.dart';
import 'presentation/screens/booking/rating_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          if (themeProvider.themeData == null) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
              ),
            );
          }

          // ✅ Web → LandingPage, Mobile → SplashScreen
          final homeScreen = kIsWeb ? LandingPage() : SplashScreen();

          return MaterialApp(
            title: 'SignTaxi',
            theme: themeProvider.themeData,
            home: homeScreen,
            routes: {
              '/role': (context) => RoleSelectionScreen(),
              '/passenger-home': (context) => PassengerHomeScreen(),
              '/driver-home': (context) => DriverHomeScreen(),
              '/searching': (context) => SearchingScreen(),
              '/driver-assigned': (context) => DriverAssignedScreen(),
              '/ride-progress': (context) => RideProgressScreen(),
              '/payment': (context) => PaymentScreen(),
              '/rating': (context) => RatingScreen(),
            },
          );
        },
      ),
    );
  }
}
