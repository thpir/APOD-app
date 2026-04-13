import 'package:apod/domain/models/apod.dart';
import 'package:apod/domain/interfaces/apod_interface.dart';
import 'package:flutter/material.dart';

class ApodViewModel extends ChangeNotifier{
  late Future<Apod> apodFuture;
  final ApodInterface _apodRepository;

  ApodViewModel({required ApodInterface apodRepository}) : _apodRepository = apodRepository {
    fetchApod();
  }

  Future<void> fetchApod() async {
    apodFuture = _apodRepository.fetchApod();
    notifyListeners();
  }
}
