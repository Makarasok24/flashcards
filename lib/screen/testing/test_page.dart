import 'package:flashcards/models/decks.dart';
import 'package:flashcards/models/submission.dart';
import 'package:flashcards/screen/results/result_page.dart';
import 'package:flashcards/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key, required this.decks});
  final Decks decks;

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  int _currentQuestion = 0;
  final _answerInput = TextEditingController();
  final Submission _submission = Submission();
  final FlipCardController check = FlipCardController();
  bool isCorrect = false;
  bool isBack = false;

  void nextCard() {
    setState(() {
      if (_currentQuestion < widget.decks.cards!.length - 1) {
        _currentQuestion++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              decks: widget.decks,
              submission: _submission,
            ),
          ),
        );
      }
      check.flipcard(); // Flip back to front
    });
  }

  void submit() {
    // if (isChecked[_currentQuestion]) return;
    //code
    final currenCard = widget.decks.cards![_currentQuestion];
    String userAnswer = _answerInput.text;

    setState(() {
      _submission.addAnswer(currenCard, userAnswer);
      isCorrect = userAnswer.trim().toLowerCase() ==
          currenCard.goodAnswer.trim().toLowerCase();

      check.flipcard();
      _answerInput.clear();
      Future.delayed(const Duration(seconds: 2), () {
        nextCard();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.decks.cards;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cards!.isEmpty
              ? "No cards available!"
              : "Play(${_currentQuestion + 1} / ${cards.length} Cards)",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            cards.isEmpty
                ? const Center(
                    child: Text("No cards available!"),
                  )
                : FlipCard(
                    rotateSide: RotateSide.right,
                    controller: check,
                    onTapFlipping: false,
                    animationDuration: const Duration(milliseconds: 500),
                    frontWidget:
                        FrontCard(title: cards[_currentQuestion].titleCard),
                    backWidget: BackCard(
                        isCorrect: isCorrect,
                        getUserAnswer:
                            _submission.getAnswerFor(cards[_currentQuestion]),
                        answer: cards[_currentQuestion].goodAnswer,
                        questionTitle: cards[_currentQuestion].titleCard),
                  ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFields(
              controller: _answerInput,
            ),
            const SizedBox(
              height: 10,
            ),
            Button(
              nameButton: "Check",
              onTap: submit,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                "Score ${_submission.getScore()}/ ${widget.decks.cards!.length}")
          ],
        ),
      ),
    );
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.shade300,
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 70,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  const BackCard({
    super.key,
    required this.isCorrect,
    required this.answer,
    required this.questionTitle,
    required this.getUserAnswer,
  });
  final bool isCorrect;
  final String answer;
  final String questionTitle;
  final String getUserAnswer;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isCorrect ? Colors.green.shade300 : Colors.red.shade300,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isCorrect ? "Correct!" : "Incorrect",
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              questionTitle,
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            Text(
              getUserAnswer,
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            if (!isCorrect)
              Text(
                "Correct answer: $answer",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  const TextFields({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(

          //label: Text(labels),
          hintText: 'Aa',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
