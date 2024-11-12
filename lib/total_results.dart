import 'package:flutter/material.dart';
import 'data_store.dart'; // Import the shared data store

class TotalResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Results'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // The list of results
          Expanded(
            child: ListView.builder(
              itemCount: totalResults.length,
              itemBuilder: (context, index) {
                final result = totalResults[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result['question'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('For: ${result['for']}'),
                        Text('Against: ${result['against']}'),
                        Text('Neutral: ${result['neutral']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Back to Home button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home_screen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              ),
              child: const Text(
                'Back to Home Page',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
