import 'package:apod/data/models/apod_api.dart';
import 'package:apod/data/services/apod_api_service.dart';
import 'package:apod/domain/models/apod.dart';
import 'package:apod/domain/use_cases/apod_interface.dart';

class ApodApiRepository implements ApodInterface {
  final ApodApiService _service;

  ApodApiRepository({ApodApiService? service})
      : _service = service ?? ApodApiService();

  @override
  Future<Apod> fetchApod() async {
    final json = await _service.fetchApod();
    return ApodApi.toDomain(json);
  }

  @override
  Future<Apod> fetchApodByDate(DateTime date) async {
    final json = await _service.fetchApod(date: date);
    return ApodApi.toDomain(json);
  }
}
