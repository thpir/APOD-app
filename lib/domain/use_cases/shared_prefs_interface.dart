abstract class SharedPrefsInterface {
  Future<List<String>> readStringList(String key);
  Future<void> writeStringList(String key, List<String> values);
}
