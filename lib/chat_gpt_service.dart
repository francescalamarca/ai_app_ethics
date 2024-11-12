import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String _apiUrl = 'https://api.openai.com/v1/chat/completions';
  final String _apiKey = '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';

  Future<String> getResponse(String message) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {'role': 'user', 'content': message},
        ],
        'max_tokens': 100
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['choices'][0]['message']['content'];
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to load response');
    }
  }
}
