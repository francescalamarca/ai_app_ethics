import 'package:flutter/material.dart';
import 'rounded_button.dart';
import 'package:provider/provider.dart';
import 'chat_gpt_service.dart';
import 'question_generator.dart';

//Passing data via Navigator routes.
//Using state management solutions like Provider, Riverpod, or InheritedWidget.
class ResultsPage extends StatefulWidget {
  @override
  _ResultsPage createState() => _ResultsPage();
}

class _ResultsPage extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the Map of arguments directly
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final question = arguments['question'] ?? 'No question provided';
    final stance = arguments['stance'] ?? 'No stance provided';
    final response = arguments['response'] ?? 'No response available';

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
              'The Question: $question',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'You Answered: $stance',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'AI Response: $response',
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