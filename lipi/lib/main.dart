import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipi/main.dart';
import 'package:lipi/main.dart';
import 'package:lipi/screens/auth_screen.dart';
import 'package:lipi/screens/home_screen.dart';
import 'package:lipi/screens/intro.dart';
import 'package:lipi/states/recording_state.dart';
import 'package:lipi/themes/app_theme.dart';
import 'package:lipi/themes/theme_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => RecordingProvider()),
          ],
          child: MaterialApp(
            home: const LandingPage(),
            theme: themeNotifier.isDark ? AppTheme.dark : AppTheme.light,
            debugShowCheckedModeBanner: false,
          ),
        );
      })));
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dashboard();
  }
}
