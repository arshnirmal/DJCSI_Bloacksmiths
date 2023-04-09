import 'package:flutter/material.dart';

class TriviaResult extends StatefulWidget {
  const TriviaResult({super.key});

  @override
  State<TriviaResult> createState() => _TriviaResultState();
}

class _TriviaResultState extends State<TriviaResult> {
  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2eae2),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score is',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}
