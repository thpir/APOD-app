import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const newsKeywordsKey = 'news_keywords';
  
  Future<List<String>> readStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  Future<void> writeStringList(String key, List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, values);
  }
}
