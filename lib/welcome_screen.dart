import 'package:flutter/material.dart';
import 'rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appBackground.jpeg'), // Your background image
            fit: BoxFit.cover, // Make the background image cover the entire screen
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                'Ethical AI Generator',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, color: Colors.blueAccent),
                
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () {
                    Navigator.pushNamed(context, 'login_screen');
                  },
                ),
                RoundedButton(
                    colour: Colors.lightBlueAccent,
                    title: 'Register',
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration_screen');
                    }),
                  RoundedButton(
                    colour: Colors.blueAccent,
                    title: 'Log In As Guest',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'home_screen');
                  }),
              ]),
        ));
  }
}