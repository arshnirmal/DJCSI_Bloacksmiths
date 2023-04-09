import 'package:codeshastra/src/constants/appbar.dart';
import 'package:codeshastra/src/screens/lottery.dart';
import 'package:flutter/material.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2eae2),
      appBar: AppBarTop.appBar(const Text("")),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Text("Ease your life a bit!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffdead84),
              ),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LotteryGame())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Guess the Number",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Image.asset(
                      "assets/images/guess_game.jpg",
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffdead84),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Spin the Whell",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Image.asset(
                  "assets/images/guess_game.jpg",
                  fit: BoxFit.contain,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
