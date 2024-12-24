import 'package:flashcards/models/decks.dart';
import 'package:flutter/material.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key, required this.decks});
  final Decks decks;

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  void addNewCard(String title, String goodAnswer) {
    setState(() {
      final newCardItem = Cards(
        titleCard: title,
        goodAnswer: goodAnswer,
      );
      widget.decks.cards!.add(newCardItem);
    });
  }

  void _showAddCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController titleController = TextEditingController();
        final TextEditingController answerController = TextEditingController();
        return AlertDialog(
          title: const Text("Add New Card"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Card Title"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(labelText: "Card Answer"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final answer = answerController.text.trim();

                if (title.isNotEmpty && answer.isNotEmpty) {
                  addNewCard(title, answer);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Add new card successfully!'),
                      backgroundColor: Colors.green.shade400,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please fill all information!'),
                      backgroundColor: Colors.red.shade400,
                    ),
                  );
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.decks.cards;
    Widget content = const Center(
      child: Text("No item yet!"),
    );

    if (cards!.isNotEmpty) {
      content = ListView.builder(
        shrinkWrap: true, // Allows ListView to size itself within Column
        physics:
            const NeverScrollableScrollPhysics(), // Disable ListView's scroll
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return CardTile(
            title: cards[index].titleCard, // Card title
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.decks.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [content],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCardDialog(context);
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        tooltip: "Add New Card",
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  const CardTile({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 40,
        ),
      ),
    );
  }
}