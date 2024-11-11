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

  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
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
      body: Center(
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
                Navigator.pushNamed(
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
                Navigator.pushNamed(
                  context,
                  'question_generator',
                  arguments: {},
                );
              }
            ),
            ],
        ),
      ),
    );
  }
}