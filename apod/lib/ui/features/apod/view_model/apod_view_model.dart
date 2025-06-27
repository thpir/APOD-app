import 'package:apod/domain/models/apod.dart';
import 'package:apod/domain/interfaces/apod_interface.dart';
import 'package:flutter/material.dart';

class ApodViewModel extends ChangeNotifier{
  late Future<Apod> _apodFuture;
  final ApodInterface _apodRepository;

  ApodViewModel({required ApodInterface apodRepository}) : _apodRepository = apodRepository {
    fetchApod();
  }

  Future<Apod> get apodFuture => _apodFuture;
  VoidCallback get fetchApod => _fetchApod;

  Future<void> _fetchApod() async {
    _apodFuture = _apodRepository.fetchApod();
    notifyListeners();
  }
}
