import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_gpt_service.dart';
import 'rounded_button.dart';
import 'results_screen.dart';


class QuestionGenerator extends StatefulWidget {
  @override
  _QuestionGeneratorState createState() => _QuestionGeneratorState();
}

//idea behind this is to grey out the unused option the user does not choose when either creating  OR choosing a preset question
class _QuestionGeneratorState extends State<QuestionGenerator> {
  String? selectedPreset;
  bool isCustomQuestionEnabled = true;  // Manage whether the custom question field is enabled
  bool isPresetQuestionEnabled = true;  // Manage whether the preset dropdown is enabled

  // List of preset questions for the dropdown - hardcoded
  List<String> presetQuestions = ['Is AI ethical?', 'Should AI replace humans?', 'Unemployment because of AI a reasonable ethical concern.'];

  TextEditingController customQuestionController = TextEditingController();
  final List<String> _customMessages = [];

  @override
  void dispose() {
    customQuestionController.dispose();
    super.dispose();
  }

  handleSubmitted(String stance, String question) async {
    // Logic to send message to gpt will go here
    if (question.isEmpty) return;

    customQuestionController.clear();
    setState(() {
      _customMessages.add('User: $stance, $question');
    });

    try {
      final String response = await ChatGPTService().getResponse('$stance: $question');

      setState(() {
        _customMessages.add('ChatGPT: $response');
      });

      // Navigate to results screen with question, stance, and response
      Navigator.pushNamed(
        context,
        'results_screen',
        arguments: {
          'question': question,
          'stance': stance,
          'response': response,  // Pass the response here
        } as Map<String, String?>,
      );
    } catch (e) {
      print("Error getting a response: $e");
    }
  } //end handleSubmitted


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ethical AI Question Generator'),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
            'For this question generator, enter your own query or choose a preset question, once chosen select a stance you would take to submit.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),

          // AI Preset Questions Dropdown
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9, // Responsive width
            ),
            child: DropdownButtonFormField<String>(
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
                  child: Text(question),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // My Question TextField
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

          // Reset and Back to Home Buttons
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
          RoundedButton(
            colour: Colors.lightBlueAccent,
            title: "Back to Home",
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                'home_screen',
                arguments: {},
              );
            },
          ),
        ],
      ),
    ),
  );
  }
}