import 'package:flashcards/data/dummy_item.dart';
import 'package:flashcards/data/progress_storage.dart';
import 'package:flashcards/models/decks.dart';
import 'package:flashcards/screen/flashcard/card.dart';
import 'package:flashcards/screen/testing/test_page.dart';
import 'package:flashcards/widget/icon_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> progress = {};
  @override
  void initState() {
    super.initState();
    _fetchProgress();
  }

  Future<void> _fetchProgress() async {
    // Assuming `dummyDeckItems` is a list of deck titles
    List<String> deckNames = dummyDeckItems.map((deck) => deck.title).toList();

    final data = await ProgressStorage.getAllProgress(deckNames);
    setState(() {
      progress = data; // Store all progress data for multiple decks
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No item yet!"),
    );

    if (dummyDeckItems.isNotEmpty) {
      content = ListView.builder(
        shrinkWrap: true, // Allow ListView to size itself
        physics:
            const NeverScrollableScrollPhysics(), // Avoid conflict with SingleChildScrollView
        itemCount: dummyDeckItems.length,
        itemBuilder: (ctx, index) => DecksTile(
          decks: dummyDeckItems[index],
          progress: progress[dummyDeckItems[index].title] ?? 0,
          onTap: () {
            showModalBottomSheet<void>(
              backgroundColor: Colors.blue.shade200,
              sheetAnimationStyle: AnimationStyle(),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Iconbutton(
                          iconButtonName: "Open the deck",
                          category: Category.card,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardsPage(
                                  decks: dummyDeckItems[index],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Iconbutton(
                          iconButtonName: "Start Testing",
                          category: Category.test,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestingScreen(
                                  decks: dummyDeckItems[index],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Iconbutton(
                          iconButtonName: "Rename",
                          category: Category.edit,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Iconbutton(
                          iconButtonName: "Delete",
                          category: Category.delete,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red,
                      image: const DecorationImage(
                        image: AssetImage("assets/image/makaraS.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Makara Sok"), Text("6th Grade")],
                  )
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Search",
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              content, // Display ListView or "No item yet!"
            ],
          ),
        ),
      ),
    );
  }
}

class DecksTile extends StatelessWidget {
  const DecksTile(
      {super.key,
      required this.decks,
      required this.onTap,
      required this.progress});

  final Decks decks;
  final VoidCallback onTap;
  final double progress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10), // Add spacing between tiles
        padding: const EdgeInsets.all(10),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                image: DecorationImage(
                  image: AssetImage(decks.image!),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    decks.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    backgroundColor: Colors.blue.shade100,
                    value: progress,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const SizedBox(height: 5),
                  Text("${(progress * 100).toStringAsFixed(2)}%"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
