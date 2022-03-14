import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
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
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //add icons
  void addIcon(bool answer) {
    setState(() {
      if (quizBrain.isGameOver() == false) {
        if (quizBrain.getQuestionsAnswer() == answer) {
          quizBrain.scoreKeeper
              .add(const Icon(Icons.check, color: Colors.green));
          quizBrain.setRightAnswers();
          quizBrain.nextQuestion();
        } else {
          quizBrain.scoreKeeper
              .add(const Icon(Icons.cancel, color: Colors.red));
          quizBrain.nextQuestion();
        }
      } else {
        Alert(
          context: context,
          title: 'Game Over',
          desc:
              'You have scored ${quizBrain.getRightAnswers()} out of ${quizBrain.getLength()}',
          buttons: [
            DialogButton(
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  quizBrain.resetGame();
                });
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                addIcon(true);
                // quizBrain.nextQuestion();
              },
              child: const Text(
                'True',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.green),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                addIcon(false);
              },
              child: const Text(
                'False',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: quizBrain.scoreKeeper,
        )
      ],
    );
  }
}
