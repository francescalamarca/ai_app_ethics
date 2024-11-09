import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'question_generator.dart';
import 'results_screen.dart';
import 'package:device_preview/device_preview.dart';
import "package:http/http.dart" as http;
import "dart:convert";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode, //only see preview in debug mode
      //   builder: (context) => MyApp()
      // ),
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
        'results_screen.dart': (context) => ResultsPage()
      },
    );
  }
  
}

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key, required this.title});

  final String title;

  @override
  _AboutUsPageState createState() => _AboutUsPageState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us',
      theme: ThemeData(
        primaryColor: Color(0xFFE4002B), // SMU Red
        secondaryHeaderColor: Color(0xFF003D73), // SMU Blue
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFE4002B), // SMU Red for AppBar
          foregroundColor: Colors.white, // White text on app bar
        ),
        colorScheme: ColorScheme.light(
          primary: Color(0xFFE4002B), // SMU Red
          secondary: Color(0xFF003D73), // SMU Blue
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFE4002B), // SMU Red
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF003D73), // SMU Blue
          ),
          bodyLarge: TextStyle(
            color: Colors.black87, // Regular body text color
          ),
          bodyMedium: TextStyle(
            color: Colors.black54, // Slightly lighter body text
          ),
        ),
        useMaterial3: true,
      ),
      home: const AboutUsPage(title: 'About Us'),
    );
  }
}

class _AboutUsPageState extends State<AboutUsPage> {
  // Variables to track the hover state
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFFE4002B), // SMU Red for AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/convert.png'), // Your background image
            fit: BoxFit.cover, // Make the background image cover the entire screen
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Card to wrap "Meet the Team" and "Tool Summary"
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "Meet the Team" Header
                      Text(
                        'Our Tool Summary:',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE4002B), // SMU Red
                            ),
                      ),
                      const SizedBox(height: 10), // Space between header and summary

                      // Tool Summary
                      Text(
                        'Our tool uses ChatGPT to take user questions, and responds to it based on the stance they input(for or against). For our purposes, preset questions have been hardcoded, but in a full model ChatGPT would generate preset questions as well.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Team Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the row
                children: [
                  // First person
                  _buildTeamMemberCard(
                    context,
                    'assets/ethanchou.png',
                    'Ethan Chou',
                    'Plano, TX\nComputer Science B.S. With AI Specialization\nSoftware Engineer\nHas a pet turtle',
                  ),
                  const SizedBox(width: 20), // Space between images

                  // Second person
                  _buildTeamMemberCard(
                    context,
                    'assets/francesca.png',
                    'Francesca La Marca',
                    'San Diego, CA\nComputer Science B.S General Track, Math Minor\nHas a twin at TCU',
                  ),
                  const SizedBox(width: 20), // Space between images

                  // Third person
                  _buildTeamMemberCard(
                    context,
                    'assets/marioneogboi.png',
                    'Marione Ogboi',
                    'Garland, TX\nComputer Science B.S. With AI Specialization, Math Minor\nDigital artist in free time',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Go Back Button wrapped with MouseRegion to handle hover effects
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHovered = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHovered = false;
                  });
                },
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // This will pop the current screen and go back
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _isHovered ? Colors.red : Colors.white, // Text color
                    backgroundColor: _isHovered ? Colors.white : Color(0xFFE4002B), // Button color
                  ),
                  child: const Text('Go Back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom widget to build the card for each team member
  Widget _buildTeamMemberCard(
      BuildContext context, String imagePath, String name, String funFacts) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 280, // Set a fixed height for the card
        width: 150,  // Set a fixed width for the card
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003D73), // SMU Blue
                    ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  funFacts,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


