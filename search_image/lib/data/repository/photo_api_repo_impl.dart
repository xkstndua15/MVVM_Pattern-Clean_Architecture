import 'package:search_image/data/data_source/pixabay_api.dart';
import 'package:search_image/data/data_source/result.dart';
import 'package:search_image/domain/model/photo.dart';
import 'package:search_image/domain/model/repository/photo_api_repo.dart';
import 'package:http/http.dart' as http;

class PhotoApiRepositoryApiImpl implements PhotoApiRepo {
  final api = PixabayApi(http.Client());

  PhotoApiRepositoryApiImpl(PixabayApi pixabayApi);

  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    final Result<Iterable> result = await api.fetch(query);

    return result.when(success: (iterable) {
      return Result.success(iterable.map((e) => Photo.fromJson(e)).toList());
    }, error: (msg) {
      return Result.error(msg);
    });
  }
}
