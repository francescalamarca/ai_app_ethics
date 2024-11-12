import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'question_generator.dart';
import 'results_screen.dart';
import 'about_us_page.dart';
import 'forgot_password.dart';
import 'package:device_preview/device_preview.dart';
import "package:http/http.dart" as http;
import "dart:convert";

//for gpt
import 'dart:io';
import 'chat_gpt_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  
    await dotenv.load();  // Try to load the environment variables
    String? apiKey = dotenv.env['YOUR_API_KEY'];
if (apiKey == null) {
  print('Error: API Key not found');
} else {
  print('API Key Loaded: $apiKey');
}
    runApp(
      DevicePreview(
        // enabled: !kReleaseMode, //only see preview in debug mode
        builder: (context) => MyApp()
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
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
        'question_generator': (context) => QuestionGenerator(),
        'results_screen': (context) => ResultsPage(),
        'about_us_page': (context) => AboutUsPage(title: "About Us"),
        'forgot_password': (context) => ForgotPassword(),
      },
    );
  }
  
}