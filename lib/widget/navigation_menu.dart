import 'package:flashcards/data/dummy_item.dart';
import 'package:flashcards/models/decks.dart';
import 'package:flashcards/screen/create_decks.dart';
import 'package:flashcards/screen/home_page.dart';
import 'package:flashcards/screen/profile.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({
    super.key,
  });
  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;

  void _addNewDeck(String title, String? imagePath) {
    setState(() {
      dummyDeckItems.add(
        Decks(
          title: title,
          image: imagePath,
          cards: [],
        ),
      );
      currentIndex = 0;
    });
  }

  late final List<Widget> pages;
  @override
  void initState() {
    super.initState();
    pages = [
      const HomePage(),
      CreatDeck(onAddDeck: _addNewDeck),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.shade200,
        indicatorShape: const CircleBorder(),
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Create Deck',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
