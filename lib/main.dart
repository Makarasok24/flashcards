import 'package:flashcards/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcards App',
      initialRoute: Routes.welcome,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
