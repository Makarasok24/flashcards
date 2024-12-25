import 'dart:io';

import 'package:flashcards/data/dummy_item.dart';
import 'package:flashcards/data/progress_storage.dart';
import 'package:flashcards/models/decks.dart';
import 'package:flashcards/screen/create_decks.dart';
import 'package:flashcards/screen/flashcard/card.dart';
import 'package:flashcards/screen/testing/test_page.dart';
import 'package:flashcards/widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Mode { creating, editing }

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> progress = {};
  String username = "Makara Sok";
  String email = "makarasok@gmail.com";
  File? profileImage;
  @override
  void initState() {
    super.initState();
    _fetchProgress();
    _fetchProfileInfo();
  }

  Future<void> _fetchProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? username;
      email = prefs.getString('email') ?? email;
      String? profilePath = prefs.getString('profilePath');
      if (profilePath != null) {
        profileImage = File(profilePath);
      }
    });
  }

  Future<void> _fetchProgress() async {
    // Assuming `dummyDeckItems` is a list of deck titles
    List<String> deckNames = dummyDeckItems.map((deck) => deck.title).toList();

    final data = await ProgressStorage.getAllProgress(deckNames);
    setState(() {
      progress = data; // Store all progress data for multiple decks
    });
  }

  void _addNewDeck() async {
    final newItem = await Navigator.of(context).push<Decks>(
      MaterialPageRoute(
        builder: (ctx) => const CreateDeck(
          mode: Mode.creating,
        ),
      ),
    );

    if (newItem != null) {
      setState(() {
        dummyDeckItems.add(newItem);
      });
    }
  }

  void _editItem(int index) async {
    final editItem = await Navigator.of(context).push<Decks>(
      MaterialPageRoute(
        builder: (ctx) => CreateDeck(
          mode: Mode.editing,
          deck: dummyDeckItems[index],
        ),
      ),
    );

    if (editItem != null) {
      setState(() {
        String oldTitle = dummyDeckItems[index].title;
        String oldImage = dummyDeckItems[index].image!;
        String newTitle = editItem.title;
        String newImage = editItem.image ?? "";
        dummyDeckItems[index] = Decks(
          title: editItem.title,
          image: editItem.image!.isNotEmpty ? newImage : oldImage,
          cards: dummyDeckItems[index].cards,
        );
        if (oldTitle != newTitle && progress.containsKey(oldTitle)) {
          progress[newTitle] = progress[oldTitle]!;
          progress.remove(oldTitle);
        }

        if (oldImage != newImage && progress.containsKey(oldImage)) {
          progress[newImage] = progress[oldImage]!;
          progress.remove(oldImage);
        }
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      dummyDeckItems.removeAt(index);
    });
  }

  void _showDelete(int index) {
    showDialog(
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blue.shade100,
        title: const Text("Delete Deck"),
        content: const Text("Are you sure you want to delete this deck?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteItem(index);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No item yet!"),
    );

    if (dummyDeckItems.isNotEmpty) {
      content = ListView.builder(
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
                          onTap: () {
                            Navigator.pop(context);
                            _editItem(index);
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Iconbutton(
                          iconButtonName: "Delete",
                          category: Category.delete,
                          onTap: () => _showDelete(index),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1.5, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: profileImage == null
                        ? const Center(
                            child: Text(
                              "あ", // Placeholder character
                              style: TextStyle(fontSize: 40),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              profileImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(username), Text(email)],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: content,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDeck,
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        tooltip: "Add New Deck",
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
        height: 140,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            decks.image!.isEmpty
                ? Container(
                    width: 80,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 4, color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "あ",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  )
                : Image.file(
                    File(decks.image!),
                    height: 120,
                    width: 80,
                    fit: BoxFit.cover,
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
