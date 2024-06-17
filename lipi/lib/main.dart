import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lipi/firebase_options.dart';
import 'package:lipi/providers/auth_provider.dart';
import 'package:lipi/providers/data_provider.dart';
import 'package:lipi/providers/play_audio_provider.dart';
import 'package:lipi/providers/record_audio_provider.dart';
import 'package:lipi/screens/auth_screen.dart';
import 'package:lipi/screens/dashboard_screen.dart';
import 'package:lipi/themes/app_theme.dart';
import 'package:lipi/themes/theme_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   appleProvider: AppleProvider.appAttest,
  // );
  runApp(const EntryRoot());
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthStateProvider()),
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => Data()),
      ],
      child: Consumer<ThemeModel>(builder: (context, value, child) {
        final AuthStateProvider auth = Provider.of<AuthStateProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lipi',
          theme: value.isDark ? AppTheme.dark : AppTheme.light,
          home: auth.isAuthenticated == true ? DashBoardScreen() : LoginPage(),
        );
      }),
    );
  }
}
