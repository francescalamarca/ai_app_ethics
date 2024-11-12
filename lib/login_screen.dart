import 'package:firebase_auth/firebase_auth.dart';
import 'rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appBackground.jpeg'), // Background image
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Ethical AI Generator',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black), // Add color for visibility
                ),
                SizedBox(height: 20.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter password',
                  ),
                ),
                SizedBox(height: 24.0),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Submit',
                  onPressed: () async {
                    Navigator.pushReplacementNamed(
                      context,
                      'home_screen', // Adjusted to a meaningful route
                    );
                  },
                ),
                SizedBox(height: 24.0),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Forgot Password',
                  onPressed: () async {
                    Navigator.pushReplacementNamed(
                      context,
                      'forgot_password', // Adjusted to a meaningful route
                    );
                  },
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: "Back to Welcome Screen",
                      onPressed: () {
                        // Your 'For' action
                        Navigator.pushReplacementNamed( //this will take the back button option away back at the home page
                          context, 
                          'welcome_screen',
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
      ),
    );
  }
}