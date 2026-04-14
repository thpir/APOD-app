import 'package:apod/data/services/image_downloader_service.dart';
import 'package:apod/domain/use_cases/image_downloader_interface.dart';
import 'package:path/path.dart' as path;

class ImageDownloaderRepository implements ImageDownloaderInterface {
  final ImageDownloaderService _service;

  ImageDownloaderRepository({ImageDownloaderService? service})
      : _service = service ?? ImageDownloaderService();

  @override
  Future<void> downloadAndSaveImage(String imageUrl) async {
    final bytes = await _service.downloadBytes(imageUrl);

    final directory = await _service.pickDirectory();
    if (directory == null) {
      throw Exception('No directory selected');
    }

    await _service.saveFile(directory, path.basename(imageUrl), bytes);
  }
}
