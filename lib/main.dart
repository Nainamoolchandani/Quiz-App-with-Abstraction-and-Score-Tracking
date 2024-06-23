import 'dart:core';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/material.dart';
import 'package:quizlerapp/quizbrain.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}
class _QuizzlerState extends State<Quizzler> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  void showIcon(bool userCheck) {
    bool correctAns = quizBrain.getQuestionAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (correctAns == userCheck) {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion(context);
      }
    });
  }

  QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 10,
            child: Center(
                child: Text(
              quizBrain.getQuestionOnly(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  showIcon(true);
                },
                child: const Text(
                  'TRUE',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  showIcon(false);
                },
                child: const Text(
                  'FALSE',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      ),
    );
  }
}
