import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';

class FileSaver {
  Future<String?> saveImage(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      final String? externalStorageDirectory = await FilePicker.platform.getDirectoryPath();
      File file = File(path.join(externalStorageDirectory!, path.basename(imageUrl)));
      await file.writeAsBytes(response.bodyBytes);
      return 'Image saved successfully';
    } catch (e) {
      return 'Failed to save image';
    }
  }
}
