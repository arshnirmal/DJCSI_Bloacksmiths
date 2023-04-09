import 'dart:math';
import 'package:codeshastra/src/constants/appbar.dart';
import 'package:flutter/material.dart';

class LotteryGame extends StatefulWidget {
  const LotteryGame({super.key});

  @override
  _LotteryGameState createState() => _LotteryGameState();
}

class _LotteryGameState extends State<LotteryGame> {
  int _selectedNumber = 0;
  bool _isNumberSelected = false;

  void _selectNumber() {
    setState(() {
      _selectedNumber = Random().nextInt(100) + 1;
      _isNumberSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop.appBar(const Text("Games")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isNumberSelected ? Colors.green : Colors.grey,
              ),
              child: Center(
                child: Text(
                  _isNumberSelected ? '$_selectedNumber' : '?',
                  style: const TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectNumber,
              child: const Text('Generate Number'),
            ),
          ],
        ),
      ),
    );
  }
}
