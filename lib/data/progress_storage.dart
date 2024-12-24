import 'package:shared_preferences/shared_preferences.dart';

class ProgressStorage {
  static const String _keyPrefix = 'deck_progress_';

  /// Save progress for a specific deck
  static Future<void> saveProgress(String deckName, double progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$_keyPrefix$deckName', progress);
  }

  /// Retrieve progress for a specific deck
  static Future<double> getProgress(String deckName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('$_keyPrefix$deckName') ?? 0.0; // Default to 0
  }

  /// Retrieve progress for all decks
  static Future<Map<String, double>> getAllProgress(
      List<String> deckNames) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, double> progressMap = {};

    for (String deckName in deckNames) {
      final progress = prefs.getDouble('$_keyPrefix$deckName') ?? 0.0;
      progressMap[deckName] = progress;
    }

    return progressMap;
  }
}
