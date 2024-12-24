import 'package:flashcards/models/decks.dart';

class Answer {
  Cards cards;
  String inputAnswer;

  Answer({required this.cards, required this.inputAnswer});

  bool isCorrect() {
    return inputAnswer.trim().toLowerCase() ==
        cards.goodAnswer.trim().toLowerCase();
  }
}

class Submission {
  List<Answer> answers = [];

  int getScore() {
    int totalScore = 0;
    for (var answer in answers) {
      if (answer.isCorrect()) {
        totalScore++;
      }
    }
    return totalScore;
  }

  void addAnswer(Cards cards, String answer) {
    answers.add(Answer(cards: cards, inputAnswer: answer));
  }

  // get answer
  String getAnswerFor(Cards cards) {
    for (var answer in answers) {
      if (answer.cards == cards) {
        return answer.inputAnswer;
      }
    }
    return "No answer";
  }

  // remove Answer
  void removeAnswers() {
    answers.clear();
  }
}
