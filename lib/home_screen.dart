import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'rounded_button.dart';
import 'results_screen.dart';

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

  //using this function you can use the credentials of the user
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(
                  context,
                  'welcome_screen',
                  arguments: {},
                );

                //Implement logout functionality
              }),
        ],
        title: Text('Ethical AI Generator Home'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
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
              onPressed:() async{
                Navigator.pushReplacementNamed(
                  context,
                  'about_us_page',
                  arguments: {},
                );
              }
            ),
            const SizedBox(height: 20),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Question Generator',
              onPressed:() async{
                Navigator.pushReplacementNamed(
                  context,
                  'question_generator',
                  arguments: {},
                );
              }
            ),
            const SizedBox(height: 20),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: "Results Page",
                    onPressed: () {
                      // Your 'For' action
                      Navigator.pushReplacementNamed( //this will take the back button option away back at the home page
                        context, 
                        'results_screen',
                        arguments: {
                            //none  to pass
                        },
                      );
                    },
                    // child: const Text('Back to Home'),
                  ),
              ],
          ),
        ),
      ),
    );
  }
}