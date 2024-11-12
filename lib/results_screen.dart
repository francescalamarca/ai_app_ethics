import 'package:flutter/material.dart';
import 'data_store.dart'; // Import the shared data store
import 'rounded_button.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    // Extract the data
    final question = arguments['question'] ?? 'Unknown Question';
    final stance = arguments['stance'] ?? 'Neutral';

    // Update the shared results data store
    _updateTotalResults(question, stance);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Ethical Response'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 84, 156, 215),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'The Question: $question',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'You Answered: $stance',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  'AI Response:',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    arguments['response'] ?? 'No response available.',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: "Back to Home Screen",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'home_screen');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

void _updateTotalResults(String question, String stance) {
  // Check if the question already exists in the totalResults list
  final existingEntryIndex = totalResults.indexWhere(
    (entry) => entry['question'] == question,
  );

  if (existingEntryIndex != -1) {
    // If the question exists, update the count for the specific stance
    final existingEntry = totalResults[existingEntryIndex];
    final stanceKey = stance.toLowerCase();
    existingEntry[stanceKey] = (existingEntry[stanceKey] ?? 0) + 1;
  } else {
    // Add a new entry for the question, initializing the correct stance with 1
    totalResults.add({
      'question': question,
      'for': stance == 'For' ? 1 : 0,
      'against': stance == 'Against' ? 1 : 0,
      'neutral': stance == 'Neutral' ? 1 : 0,
    });
  }

  // Debugging output to track state
}


}
