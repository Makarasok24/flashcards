import 'package:flashcards/data/progress_storage.dart';
import 'package:flashcards/models/decks.dart';
import 'package:flashcards/models/submission.dart';
import 'package:flashcards/router/router.dart';
import 'package:flashcards/screen/testing/test_page.dart';
import 'package:flashcards/widget/icon_button.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.decks,
    required this.submission,
  });
  final Decks decks;
  final Submission submission;
  @override
  Widget build(BuildContext context) {
    double prgress = submission.getScore() / decks.cards!.length;

    // save progress
    ProgressStorage.saveProgress(decks.title, prgress);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text('Accuracy Rate'),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${(prgress * 100).toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'You got ${submission.getScore()} out of ${decks.cards?.length} questions right'),
              const SizedBox(
                height: 20,
              ),
              // Feedback message
              Text('You can do better next time'),
              const SizedBox(
                height: 20,
              ),
              Iconbutton(
                iconButtonName: "Test again",
                category: Category.restart,
                color: Colors.blue.shade400,
                textColor: Colors.white,
                onTap: () {
                  submission.removeAnswers();
                  Navigator.pushNamed(context, Routes.test, arguments: decks);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Iconbutton(
                iconButtonName: "End",
                category: Category.end,
                color: Colors.red.shade400,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pushNamed(context, Routes.navigationMenu,
                      arguments: prgress);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: decks.cards!.length,
                  itemBuilder: (context, index) {
                    return ResultCard(
                      questionTitle: decks.cards![index].titleCard,
                      goodAnswer: decks.cards![index].goodAnswer,
                      isCorrect: submission.getAnswerFor(decks.cards![index]) ==
                          decks.cards![index].goodAnswer,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final String questionTitle;
  final String goodAnswer;
  final bool isCorrect;

  const ResultCard({
    super.key,
    required this.goodAnswer,
    required this.questionTitle,
    required this.isCorrect,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          // i will have conditional statement here for the border color
          color: isCorrect ? Colors.green.shade300 : Colors.red.shade300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            isCorrect
                ? Icons.check_circle_outline
                : Icons
                    .cancel_outlined, //i will conditionally change the icon here
            color: isCorrect ? Colors.green : Colors.red,
          ),
          Column(
            children: [
              Text(
                questionTitle,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                goodAnswer,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: isCorrect ? Colors.green.shade300 : Colors.red.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
