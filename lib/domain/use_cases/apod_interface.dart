import 'package:apod/domain/models/apod.dart';

abstract class ApodInterface {
  Future<Apod> fetchApod();
  Future<Apod> fetchApodByDate(DateTime date);
}
