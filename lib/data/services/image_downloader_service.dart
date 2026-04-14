import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

typedef DirectoryPicker = Future<String?> Function();
typedef FileWriter = Future<void> Function(String path, List<int> bytes);

class ImageDownloaderService {
  final http.Client _client;
  final DirectoryPicker _directoryPicker;
  final FileWriter _fileWriter;

  ImageDownloaderService({
    http.Client? client,
    DirectoryPicker? directoryPicker,
    FileWriter? fileWriter,
  })  : _client = client ?? http.Client(),
        _directoryPicker = directoryPicker ??
            (() async => FilePicker.platform.getDirectoryPath()),
        _fileWriter = fileWriter ??
            ((filePath, bytes) async => File(filePath).writeAsBytes(bytes));

  Future<List<int>> downloadBytes(String imageUrl) async {
    final response = await _client.get(Uri.parse(imageUrl));
    if (!RegExp(r'^2\d{2}$').hasMatch(response.statusCode.toString())) {
      throw Exception('Failed to download image');
    }
    return response.bodyBytes;
  }

  Future<String?> pickDirectory() async {
    return _directoryPicker();
  }

  Future<void> saveFile(String directory, String filename, List<int> bytes) async {
    final filePath = path.join(directory, filename);
    await _fileWriter(filePath, bytes);
  }
}
