import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signtaxi_app/presentation/providers/theme_provider.dart'; // ✅ absolute import
import 'role_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => RoleSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final primaryColor = themeProvider.themeMap['colors']['primary'] as String;
    return Scaffold(
      backgroundColor: Color(int.parse('FF${primaryColor.substring(1)}', radix: 16)),
      body: Center(
        child: Text(
          'SignTaxi',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}