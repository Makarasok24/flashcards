// class FlashCards {
//   List<Decks> decks;
//   FlashCards({required this.decks});
// }

class Decks {
  String title;
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
   String titleCard;
   String goodAnswer;
  Cards({required this.titleCard, required this.goodAnswer});
}
