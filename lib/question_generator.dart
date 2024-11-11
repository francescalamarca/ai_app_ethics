import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_gpt_service.dart';


class QuestionGenerator extends StatefulWidget {
  @override
  _QuestionGeneratorState createState() => _QuestionGeneratorState();
}


//idea behind this is to grey out the unused option the user does not choose when either creating  OR choosing a preset question
class _QuestionGeneratorState extends State<QuestionGenerator> {
  String? selectedPreset;
  final TextEditingController customQuestionController = TextEditingController();
  bool isCustomQuestionEnabled = true;  // Manage whether the custom question field is enabled
  bool isPresetQuestionEnabled = true;  // Manage whether the preset dropdown is enabled

  // List of preset questions for the dropdown - hardcoded
  List<String> presetQuestions = ['Is AI ethical?', 'Should AI replace humans?', 'Unemployment because of AI a reasonable ethical concern.'];
  final List<Map<String, String>> _customMessages = [];

  @override
  void dispose() {
    customQuestionController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) async {
    // Logic to send message to gpt will go here
    if (text.isEmpty) return;

    customQuestionController.clear();
    setState(() {
      _customMessages.add({'User: $stance, $text'});
    });
    try {
      final String response = await ChatGPTService().getResponse(text);
      setState(() {
        _customMessages.add({'ChatGPT: $response'});
      });
    } catch(e) {
      print("error getting a response")
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Generator'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 84, 156, 215),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'For this question generator, enter your own query or choose a preset question, once chosen select a stance you would take to submit.',
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
              children: ['For', 'Against', 'Neutral'].map((stance) {
                return ElevatedButton(
                  onPressed: () {
                    _handleSubmitted(
                      customQuestionController.text.isEmpty ? selectedPreset! : customQuestionController.text,
                    );
                    Navigator.pushNamed(
                      context,
                      'results_screen',
                      arguments: {
                        'question': customQuestionController.text.isEmpty ? selectedPreset : customQuestionController.text,
                        'stance': stance,
                      },
                    );
                  },
                  child: Text(stance),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
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
                  child: const Text('Back to Home'),
                ),
          ],
        ),
      ),
    );
  }
}}