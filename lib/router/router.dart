import 'package:flashcards/models/decks.dart';
import 'package:flashcards/screen/home_page.dart';
import 'package:flashcards/screen/testing/test_page.dart';
import 'package:flashcards/screen/welcome_screen.dart';
import 'package:flashcards/widget/navigation_menu.dart';

import 'package:flutter/material.dart';

class Routes {
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String navigationMenu = '/navBar';
  static const String card = '/card';
  static const String test = '/test';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => const Welcomescreen());
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case navigationMenu:
        return MaterialPageRoute(builder: (context) => const NavigationMenu());
      case test:
        final decks = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => TestingScreen(
            decks: decks as Decks,
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const Welcomescreen());
    }
  }
}
