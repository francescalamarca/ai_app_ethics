import "dart:ui";
import questionGenerator.DartPluginRegistrant
import 'package:flutter/material.dart';


//Passing data via Navigator routes.
//Using state management solutions like Provider, Riverpod, or InheritedWidget.

class ResultsPage extends StatelessWidget{
  final String response;
  //will use this to display chat gpt answer which has been called to get when the generator is pressed for the for, against, or neutral buttons
  ResultsScreen ({required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Ethical Response'),
      ),
      body: Padding (
        padding: const EdgeInsets.all(20.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The Question: ${arguments['question']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'You Answered: ${arguments['stance']}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'AI Response: ${arguments['response']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}