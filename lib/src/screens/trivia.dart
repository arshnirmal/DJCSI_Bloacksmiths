import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeshastra/src/constants/appbar.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  final List<Map<String, List<String>>> _questions = [];
  double _progress = 0.0;
  String selectedOption = '';
  int score = 0;
  int index = -1;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    String data = await rootBundle.loadString('assets/triviacsv.csv');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(data);
    List<String> listOfRows = csvData.toString().split("\n");

    for (var row in listOfRows) {
      Map<String, List<String>> temp = {};
      var question = row.split(",")[0];
      List<String> listOfOptions = row.split(",").getRange(1, 6).toList();
      print('listOfOptions: $listOfOptions');
      temp[question] = listOfOptions;
      _questions.add(temp);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_progress > 1) {
      _progress = 0;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBarTop.appBar(const Text('Trivia')),
        body: index == -1
            ? Container(
                child: TextButton(
                    onPressed: () async {
                      DocumentSnapshot snap = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      if (int.parse(snap['coffee_beans']) <= 10) {
                        Fluttertoast.showToast(
                            msg: 'Insufficient Coffee beans');
                        return;
                      }
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'coffee_beans':
                            (int.parse(snap['coffee_beans']) - 10).toString()
                      });

                      setState(() {
                        index = index + 1;
                      });
                    },
                    child: const Text("Play")),
              )
            : Center(
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'It\'s Trivia Time!',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    LinearPercentIndicator(
                      backgroundColor: const Color(0xffE0E8FF),
                      lineHeight: 10.0,
                      animation: true,
                      alignment: MainAxisAlignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      barRadius: const Radius.circular(40),
                      percent: _progress,
                      progressColor: const Color(0xff563300),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffdcb9a3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: _questions.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListTile(
                                title: Text(
                                  _questions[index].keys.first,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  children: _questions[index]
                                      .values
                                      .first
                                      .getRange(0, 4)
                                      .map(
                                    (option) {
                                      return RadioListTile(
                                        title: Text(
                                          option,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                        value: option,
                                        groupValue: selectedOption,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              selectedOption = value.toString();
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff563300),
                          ),
                        ),
                        onPressed: () {
                          print(_questions[index].values.toList());
                          if (selectedOption ==
                              _questions[index].values.toList()[0][4]) {
                            score++;
                          }
                          index++;
                          if (index == _questions.length - 1) {
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              _progress += 0.2;
                            });
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  int getScore() {
    return score;
  }
}
