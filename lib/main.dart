import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'questionGenerator.dart';
import 'results.dart';
import 'package:device_preview/device_preview.dart';
import "package:http/http.dart" as http;
import "dart:convert";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
      DevicePreview(
        enabled: !kReleaseMode, //only see preview in debug mode
        builder: (context) => MyApp()
      ),
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomeScreen(),
        'questionGenerator': (context) => QuestionGenerator(),
        'results.dart': (context) => ResultsPage()
      },
    );
  }
}