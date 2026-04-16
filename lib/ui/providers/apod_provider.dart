import 'package:apod/domain/models/apod.dart';
import 'package:apod/domain/use_cases/apod_interface.dart';
import 'package:apod/domain/use_cases/image_downloader_interface.dart';
import 'package:apod/ui/core/helpers/home_widget_helper.dart';
import 'package:flutter/material.dart';

class ApodProvider extends ChangeNotifier {
  late Future<Apod> apodFuture;
  final ApodInterface _apodRepository;
  final ImageDownloaderInterface _imageDownloaderRepository;

  var _isDownloading = false;
  bool get isDownloading => _isDownloading;

  ApodProvider({
    required ApodInterface apodRepository,
    required ImageDownloaderInterface imageDownloaderRepository,
  })  : _apodRepository = apodRepository,
        _imageDownloaderRepository = imageDownloaderRepository {
    fetchApod();
  }

  Future<void> fetchApod() async {
    apodFuture = _apodRepository.fetchApod();
    notifyListeners();
    try {
      final apod = await apodFuture;
      if (apod.mediaType == 'image') {
        HomeWidgetHelper().updateWidget(apod);
      }
    } catch (_) {}
  }

  Future<void> fetchApodByDate(DateTime date) async {
    apodFuture = _apodRepository.fetchApodByDate(date);
    notifyListeners();
  }

  Future<void> downloadImage(String imageUrl) async {
    _isDownloading = true;
    notifyListeners();
    try {
      await _imageDownloaderRepository.downloadAndSaveImage(imageUrl);
    } finally {
      _isDownloading = false;
      notifyListeners();
    }
  }
}
