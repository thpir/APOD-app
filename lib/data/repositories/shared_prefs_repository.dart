import 'package:apod/data/services/shared_prefs_service.dart';
import 'package:apod/domain/use_cases/shared_prefs_interface.dart';

class SharedPrefsRepository implements SharedPrefsInterface {
  final SharedPrefsService _service;

  SharedPrefsRepository({SharedPrefsService? service})
      : _service = service ?? SharedPrefsService();

  @override
  Future<List<String>> readStringList(String key) {
    return _service.readStringList(key);
  }

  @override
  Future<void> writeStringList(String key, List<String> values) {
    return _service.writeStringList(key, values);
  }
}
