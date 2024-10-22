import 'package:flutter/material.dart';
//calling the llm model - chat gpt
const String OpenAiKey = 'ChatGPT-Key';
final List<Map<String, String>> messages = [];

class QuestionGenerator extends StatefulWidget {
  @override
  _QuestionGeneratorState createState() => _QuestionGeneratorState();
}

//idea behind this is to grey out the unused option the user does not choose when either creating  OR choosing a preset question
class _QuestionGeneratorState extends State<QuestionGenerator> {
  String? selectedPreset;
  TextEditingController customQuestionController = TextEditingController();
  bool isCustomQuestionEnabled = true;  // Manage whether the custom question field is enabled
  bool isPresetQuestionEnabled = true;  // Manage whether the preset dropdown is enabled

  // List of preset questions for the dropdown
  List<String> presetQuestions = ['Is AI ethical?', 'Should AI replace humans?', 'Unemployment because of AI a reasonable ethical concern.'];

  @override
  void dispose() {
    customQuestionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'For this question generator, enter your own query or choose a preset question, once chosen select a stance you would take and submit.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // AI Preset Questions Dropdown
            DropdownButtonFormField<String>(
              value: selectedPreset,
              hint: const Text('Select a preset question'),
              onChanged: isPresetQuestionEnabled
                  ? (newValue) {
                      setState(() {
                        selectedPreset = newValue;
                        // Disable custom text field when a preset is selected
                        isCustomQuestionEnabled = false;
                      });
                    }
                  : null, // Disable if custom question is filled
              items: presetQuestions.map((question) {
                return DropdownMenuItem(
                  value: question,
                  child: Text(question),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            
            // My Question TextField
            TextFormField(
              controller: customQuestionController,
              decoration: const InputDecoration(labelText: 'My Question'),
              enabled: isCustomQuestionEnabled, // Disable if preset question is chosen
              onChanged: (text) {
                setState(() {
                  // Disable preset dropdown when a custom question is entered
                  isPresetQuestionEnabled = text.isEmpty;
                  //logic for passing question into AI here
                });
              },
            ),
            const SizedBox(height: 20),

            // For, Against, Neutral Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Your 'For' action
                    Navigator.pushNamed(context, 'results_screen', arguments: "For");
                  },
                  child: const Text('For'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Your 'Against' action
                    Navigator.pushNamed(context, 'results_screen', arguments: "Against");
                  },
                  child: const Text('Against'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Your 'Neutral' action
                    Navigator.pushNamed(context, 'results_screen', arguments: 'Neutral'); //arguments will allow me to pass stance to results page
                  },
                  child: const Text('Neutral'),
                ),
              ],
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
