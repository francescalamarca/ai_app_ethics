import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatGPTService {
  final String _apiUrl = 'https://api.openai.com/v1/chat/completions';
  final String _apiKey = dotenv.env['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']!;

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
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': message}
        ],
        'max_tokens': 60
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