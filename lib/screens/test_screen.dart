import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentQuestion = 0;
  String? selectedAnswer;
  String? resultMessage;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the capital of France?",
      "options": ["Berlin", "Paris", "Rome", "Madrid"],
      "answer": "Paris",
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Earth", "Mars", "Jupiter", "Venus"],
      "answer": "Mars",
    },
    {
      "question": "What is the largest ocean on Earth?",
      "options": ["Atlantic", "Indian", "Pacific", "Arctic"],
      "answer": "Pacific",
    },
    {
      "question": "Who wrote 'Romeo and Juliet'?",
      "options": ["Shakespeare", "Dickens", "Hemingway", "Tolkien"],
      "answer": "Shakespeare",
    },
    {
      "question": "Which gas do plants absorb from the atmosphere?",
      "options": ["Oxygen", "Carbon Dioxide", "Nitrogen", "Hydrogen"],
      "answer": "Carbon Dioxide",
    },
  ];

  void checkAnswer(String option) {
    setState(() {
      selectedAnswer = option;
      if (option == questions[currentQuestion]["answer"]) {
        resultMessage = "✅ Correct!";
      } else {
        resultMessage = "❌ Incorrect";
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        resultMessage = null;
      });
    } else {
      // Last question: finish test
      Navigator.pop(context); // Go back to previous page (Test/Study page)
      // OR replace with:
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StudyScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var question = questions[currentQuestion];
    bool isLastQuestion = currentQuestion == questions.length - 1;

    return Scaffold(
      appBar: AppBar(title: const Text("Test Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question["question"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...question["options"].map<Widget>((option) {
              return ElevatedButton(
                onPressed: () => checkAnswer(option),
                child: Text(option),
              );
            }).toList(),
            const SizedBox(height: 20),
            if (resultMessage != null)
              Text(
                resultMessage!,
                style: TextStyle(
                  fontSize: 18,
                  color: resultMessage!.contains("Correct")
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            const SizedBox(height: 20),
            if (resultMessage != null)
              ElevatedButton(
                onPressed: nextQuestion,
                child: Text(isLastQuestion ? "Finish Test" : "Next Question"),
              ),
          ],
        ),
      ),
    );
  }
}
