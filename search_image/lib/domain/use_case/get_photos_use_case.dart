import 'dart:math';

import 'package:search_image/data/data_source/result.dart';
import 'package:search_image/domain/model/photo.dart';
import 'package:search_image/domain/model/repository/photo_api_repo.dart';

class GetPhotosUseCase {
  final PhotoApiRepo repo;

  GetPhotosUseCase(this.repo);

  Future<Result<List<Photo>>> call(String query) async {
    final result = await repo.fetch(query);

    return result.when(success: (photos) {
      return Result.success(photos.sublist(0, min(10, photos.length)));
    }, error: (msg) {
      return Result.error(msg);
    });
  }
}
