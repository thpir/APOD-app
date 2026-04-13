import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

typedef DirectoryPicker = Future<String?> Function();
typedef FileWriter = Future<void> Function(String path, List<int> bytes);

class ImageDownloaderRepository {
  final http.Client _client;
  final DirectoryPicker _directoryPicker;
  final FileWriter _fileWriter;

  ImageDownloaderRepository({
    http.Client? client,
    DirectoryPicker? directoryPicker,
    FileWriter? fileWriter,
  })  : _fileWriter = fileWriter ??
            ((path, bytes) async {
              await File(path).writeAsBytes(bytes);
            }),
        _directoryPicker = directoryPicker ??
            (() async {
              return await FilePicker.platform.getDirectoryPath();
            }),
        _client = client ?? http.Client();

  Future<void> downloadAndSaveImage(String imageUrl) async {
    final response = await _client.get(Uri.parse(imageUrl));
    final regex = RegExp(r'^2\d{2}$');
    if (!regex.hasMatch(response.statusCode.toString())) {
      throw Exception('Failed to download image');
    }

    final String? directory = await _directoryPicker();
    if (directory == null) {
      throw Exception('No directory selected');
    }

    final filePath = path.join(directory, path.basename(imageUrl));
    await _fileWriter(filePath, response.bodyBytes);
  }
}
