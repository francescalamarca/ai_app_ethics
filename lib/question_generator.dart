import 'package:flutter/material.dart';
import 'chat_gpt_service.dart';
import 'rounded_button.dart';

class QuestionGenerator extends StatefulWidget {
  @override
  _QuestionGeneratorState createState() => _QuestionGeneratorState();
}

class _QuestionGeneratorState extends State<QuestionGenerator> {
  String? selectedPreset;
  bool isCustomQuestionEnabled = true;
  bool isPresetQuestionEnabled = true;

  List<String> presetQuestions = [
    'Is AI ethical?',
    'Should AI replace humans?',
    'Unemployment because of AI is a reasonable ethical concern.',
  ];

  TextEditingController customQuestionController = TextEditingController();

  @override
  void dispose() {
    customQuestionController.dispose();
    super.dispose();
  }

  handleSubmitted(String stance, String question) async {
    if (question.isEmpty) return;

    customQuestionController.clear();

    try {
      final String response = await ChatGPTService().getResponse('$stance: $question');

      // Navigate to results screen with question, stance, and response
      Navigator.pushNamed(
        context,
        'results_screen',
        arguments: {
          'question': question,
          'stance': stance,
          'response': response,
        } as Map<String, String?>,
      );
    } catch (e) {
      print("Error getting a response: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ethical AI Question Generator'),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appBackground.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'For this question generator, enter your own query or choose a preset question. Once chosen, select a stance to submit.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Dropdown Button
            DropdownButtonFormField<String>(
              value: selectedPreset,
              hint: const Text('Select a preset question'),
              onChanged: isPresetQuestionEnabled
                  ? (newValue) {
                      setState(() {
                        selectedPreset = newValue;
                        isCustomQuestionEnabled = false;
                      });
                    }
                  : null,
              items: presetQuestions.map((question) {
                return DropdownMenuItem(
                  value: question,
                  child: Text(
                    question,
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                    maxLines: 1,
                  ),
                );
              }).toList(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
            ),
            const SizedBox(height: 20),

            // Custom Question TextField
            TextFormField(
              controller: customQuestionController,
              decoration: const InputDecoration(labelText: 'My Question'),
              enabled: isCustomQuestionEnabled,
              onChanged: (text) {
                setState(() {
                  isPresetQuestionEnabled = text.isEmpty;
                });
              },
            ),
            const SizedBox(height: 20),

            // Stance Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['For', 'Against', 'Neutral'].map((stance) {
                return Expanded(
                  child: RoundedButton(
                    colour: Colors.lightBlueAccent,
                    title: stance,
                    onPressed: () {
                      final String question = customQuestionController.text.isEmpty
                          ? selectedPreset!
                          : customQuestionController.text;
                      handleSubmitted(stance, question);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Reset Filters Button
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: "Reset Filters",
              onPressed: () {
                setState(() {
                  selectedPreset = null;
                  customQuestionController.clear();
                  isPresetQuestionEnabled = true;
                  isCustomQuestionEnabled = true;
                });
              },
            ),
            const SizedBox(height: 10),

            // Back to Home Button
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: "Back to Home",
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  'home_screen',
                  arguments: {}, // Optional if no arguments are needed
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
