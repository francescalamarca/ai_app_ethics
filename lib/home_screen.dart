import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'rounded_button.dart';

User? loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // Retrieve the currently logged-in user
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // Log out the user and navigate to the welcome screen
  void _logOut() {
    _auth.signOut();
    Navigator.pushReplacementNamed(
      context,
      'welcome_screen',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logOut,
          ),
        ],
        title: const Text('Ethical AI Generator Home'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appBackground.jpeg'), // Background image
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome User',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'About Us',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    'about_us_page',
                  );
                },
              ),
              const SizedBox(height: 20),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Question Generator',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    'question_generator',
                  );
                },
              ),
              const SizedBox(height: 20),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: "All Results Page",
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    'total_results',
                  );
                },
              ),
              const SizedBox(height: 40),
              // Add the "Log Out" button
              RoundedButton(
                colour: Colors.redAccent,
                title: "Log Out",
                onPressed: _logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
