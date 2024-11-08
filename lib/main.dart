import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key, required this.title});

  final String title;

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
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
                        'Meet Our Team:',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE4002B), // SMU Red
                            ),
                      ),
                      const SizedBox(height: 10), // Space between header and summary

                      // Tool Summary
                      Text(
                        'Our tool using ChatGPT to generate ethical qu',
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




