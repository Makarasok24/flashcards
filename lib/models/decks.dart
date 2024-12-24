// class FlashCards {
//   List<Decks> decks;
//   FlashCards({required this.decks});
// }

class Decks {
  final String title;
  final String? image;
  //card can be null when we create new deck
  List<Cards>? cards;
  Decks({
    required this.title,
    this.image,
    this.cards,
  });
}

class Cards {
  final String titleCard;
  final String goodAnswer;
  Cards({required this.titleCard, required this.goodAnswer});
}

// void main() {
//   // Create individual card objects
//   Cards card1 = Cards(titleCard: "What is あ?", goodAnswer: "a");
//   Cards card2 = Cards(titleCard: "What is い?", goodAnswer: "i");
//   Cards card3 = Cards(titleCard: "What is う?", goodAnswer: "u");
//   Submission submission = Submission();
//   // Create deck objects with lists of cards
//   Decks deck1 = Decks(
//       title: "Hiragana Deck 1",
//       image: "hiragana_deck1.png",
//       cards: [card1, card2, card3]);

//   Decks deck2 = Decks(
//       title: "Hiragana Deck 2",
//       image: "hiragana_deck2.png",
//       cards: [card3, card1]);

//   Decks deck3 = Decks(
//       title: "Hiragana Deck 3",
//       image: "hiragana_deck3.png",
//       cards: [card2, card2, card3]);

//   // Create a FlashCards object with a list of decks
//   FlashCards flashCards = FlashCards(decks: [deck1, deck2, deck3]);

//   submission.addAnswer(card1,"a");//correct
//   // Test output
//   print("Flashcards Collection:");
//   for (var deck in flashCards.decks) {
//     print("Deck Title: ${deck.title}");
//     print("Image: ${deck.image}");
//     print("Cards:");
//     for (var card in deck.cards) {
//       print("  - Card Title: ${card.titleCard}");
//       print("    Correct Answer: ${card.goodAnswer}");
//     }
//     print(""); // Add a line break between decks
//   }
// }
