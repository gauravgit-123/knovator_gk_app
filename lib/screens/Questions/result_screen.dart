import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../data/response/api_response.dart';
import '../../utils/routing/routes_name.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;

  const ResultScreen({required this.questions});

  @override
  Widget build(BuildContext context) {
    final correct = questions.where((q) => _mapAnswer(q.selectedAnswer) == _mapAnswer(q.answer)).length;
    final percent = (correct / questions.length * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(title: Text("Quiz Results")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("You got $correct out of ${questions.length} correct!", style: TextStyle(fontSize: 18)),
            Text("Score: $percent%", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text("Retry"),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, RouteName.homeScreen, (route) => false)),
            ),
          ],
        ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return Card(
                    child: ListTile(
                      title: Text(q.question ?? ""),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your answer: ${_mapAnswer(q.selectedAnswer) ?? "None"}"),
                          Text("Correct answer: ${_mapAnswer(q.answer)}"),
                          if (q.explanation != null)
                            Text("Explanation: ${q.explanation}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String _mapAnswer(String? num) {
    switch (num) {
      case "1": return "A";
      case "2": return "B";
      case "3": return "C";
      case "4": return "D";
      case "5": return "E";
      default: return "";
    }
  }
}
