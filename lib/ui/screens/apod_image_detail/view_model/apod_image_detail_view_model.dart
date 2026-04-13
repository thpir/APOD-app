import 'package:apod/data/repositories/image_downloader_repository.dart';

class ApodImageDetailViewModel {
  final ImageDownloaderRepository _imageDownloaderRepository;

  ApodImageDetailViewModel({required ImageDownloaderRepository? imageDownloaderRepository}) : _imageDownloaderRepository = imageDownloaderRepository ?? ImageDownloaderRepository();

  Future<void> downloadImage(String imageUrl) async {
    await _imageDownloaderRepository.downloadAndSaveImage(imageUrl);
  }
}
