import 'package:flutter/material.dart';
import 'rounded_button.dart';


//Passing data via Navigator routes.
//Using state management solutions like Provider, Riverpod, or InheritedWidget.

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the Map of arguments directly
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Ethical Response'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 84, 156, 215),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, //aligns children center as well
          children: [
            Text(
              'The Question: ${arguments['question']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'You Answered: ${arguments['stance']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'AI Response: ${arguments['response']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: "Back to Home Screen",
                    onPressed: () {
                      // Your 'For' action
                      Navigator.pushReplacementNamed( //this will take the back button option away back at the home page
                        context, 
                        'home_screen',
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
    );
  }
}