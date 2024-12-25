// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flashcards/models/decks.dart';

// class DataStorage {
//   static const String _decksKey = 'decks';

//   static Future<void> saveDecks(List<Decks> decks) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String encodedData =
//         jsonEncode(decks.map((deck) => deck.toJson()).toList());
//     await prefs.setString(_decksKey, encodedData);
//   }

//   // static Future<List<Decks>> getDecks() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final String? encodedData = prefs.getString(_decksKey);
//   //   if (encodedData != null) {
//   //     final List<dynamic> decodedData = jsonDecode(encodedData);
//   //     return decodedData.map<Decks>((item) => Decks.fromJson(item)).toList();
//   //   }
//   //   return [];
//   // }
//   static Future<List<Decks>> getDecks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? encodedData = prefs.getString(_decksKey);
//     if (encodedData != null) {
//       try {
//         final List<dynamic> decodedData = jsonDecode(encodedData);
//         return decodedData.map<Decks>((item) => Decks.fromJson(item)).toList();
//       } catch (e) {
//         print('Error decoding decks: $e');
//       }
//     }
//     return [];
//   }

//   /// Delete a specific deck by title
//   static Future<void> deleteDeck(String title) async {
//     final prefs = await SharedPreferences.getInstance();
//     List<Decks> decks = await getDecks();
//     decks.removeWhere((deck) => deck.title == title);
//     await saveDecks(decks);
//   }

//   /// Rename a specific deck
//   static Future<void> renameDeck(String oldTitle, String newTitle) async {
//     final prefs = await SharedPreferences.getInstance();
//     List<Decks> decks = await getDecks();
//     for (var deck in decks) {
//       if (deck.title == oldTitle) {
//         deck = Decks(title: newTitle, image: deck.image, cards: deck.cards);
//         break;
//       }
//     }
//     await saveDecks(decks);
//   }
// }

// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flashcards/models/decks.dart';

// class DataStorage {
//   static const String _decksKey = 'decks';

//   static Future<void> saveDecks(List<Decks> decks) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String encodedData =
//         jsonEncode(decks.map((deck) => deck.toJson()).toList());
//     await prefs.setString(_decksKey, encodedData);
//   }

//   static Future<List<Decks>> getDecks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? encodedData = prefs.getString(_decksKey);
//     if (encodedData != null) {
//       final List<dynamic> decodedData = jsonDecode(encodedData);
//       return decodedData.map((item) => Decks.fromJson(item)).toList();
//     }
//     return [];
//   }
// }
