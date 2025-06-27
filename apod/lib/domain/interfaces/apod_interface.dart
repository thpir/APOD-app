import 'package:apod/domain/models/apod.dart';

abstract class ApodInterface {
  Future<Apod> fetchApod();
}
