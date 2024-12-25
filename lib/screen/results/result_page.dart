import 'package:flashcards/data/progress_storage.dart';
import 'package:flashcards/models/decks.dart';
import 'package:flashcards/models/submission.dart';
import 'package:flashcards/router/router.dart';
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
    double progress = submission.getScore() / decks.cards!.length;
    int getScore = submission.getScore();
    // save progress
    ProgressStorage.saveProgress(decks.title, progress);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Accuracy Rate',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              // Text(
              //   '${(progress * 100).toStringAsFixed(2)}%',
              //   style: const TextStyle(
              //     fontSize: 50,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      strokeCap: StrokeCap.round,
                      backgroundColor: Colors.blue.shade100,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${(progress * 100).toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: Colors.green),
                      Text(
                        '$getScore corrects',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.cancel_outlined, color: Colors.red),
                      Text(
                        '${decks.cards!.length - getScore} incorrects',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Feedback message
              Text(progress >= 0.9
                  ? "Greate Work!"
                  : progress >= 0.5
                      ? "Good job, but keep improving!"
                      : 'You can do better next time'),
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
                  Navigator.pushReplacementNamed(context, Routes.navigationMenu,
                      arguments: decks);
                },
              ),
              const SizedBox(
                height: 10,
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
