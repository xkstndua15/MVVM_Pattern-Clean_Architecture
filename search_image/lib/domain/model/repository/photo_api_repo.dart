import 'package:search_image/data/data_source/result.dart';
import 'package:search_image/domain/model/photo.dart';

abstract class PhotoApiRepo {
  Future<Result<List<Photo>>> fetch(String query);
}
