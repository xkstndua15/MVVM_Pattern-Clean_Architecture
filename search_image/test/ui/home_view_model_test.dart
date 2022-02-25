import 'package:flutter_test/flutter_test.dart';
import 'package:search_image/data/data_source/result.dart';
import 'package:search_image/domain/model/repository/photo_api_repo.dart';
import 'package:search_image/domain/model/photo.dart';
import 'package:search_image/domain/use_case/get_photos_use_case.dart';
import 'package:search_image/presentation/home/home_view_model.dart';

void main() {
  test('Stream이 잘 동작해야 한다', () async {
    final viewModel = HomeViewModel(GetPhotosUseCase(FakePhotoApiRepo()));

    await viewModel.fetch('apple');

    final List<Photo> result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(viewModel.state.photos, result);
  });
}

class FakePhotoApiRepo extends PhotoApiRepo {
  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    Future.delayed(const Duration(milliseconds: 500));

    return Result.success(fakeJson.map((e) => Photo.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 1834639,
    "pageURL":
        "https://pixabay.com/photos/apple-red-fruit-food-fresh-ripe-1834639/",
    "type": "photo",
    "tags": "apple, red, fruit",
    "previewURL":
        "https://cdn.pixabay.com/photo/2016/11/18/13/47/apple-1834639_150.jpg",
    "previewWidth": 150,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/g3205d12fe368555f1d145989d43ff20b986b7e34effd34b1e6d486b7cc9cf8a53baa76a2297da66f75580e3b7842830e6a181d7c7e2fb999f4e3b414dda46b39_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/ge172047c522cdef67a33eb9cf9368990ca629179884ea249ca3add9a3827e60c56de24f91692df55895bf5a1da2caaafe35140b88b8580ee2a8577075ed81cfb_1280.jpg",
    "imageWidth": 2827,
    "imageHeight": 2827,
    "imageSize": 1022194,
    "views": 65308,
    "downloads": 38727,
    "collections": 2305,
    "likes": 157,
    "comments": 38,
    "user_id": 2286921,
    "user": "Pexels",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/26/22-06-36-459_250x250.jpg"
  },
  {
    "id": 1122537,
    "pageURL":
        "https://pixabay.com/photos/apple-water-droplets-fruit-moist-1122537/",
    "type": "photo",
    "tags": "apple, water droplets, fruit",
    "previewURL":
        "https://cdn.pixabay.com/photo/2016/01/05/13/58/apple-1122537_150.jpg",
    "previewWidth": 150,
    "previewHeight": 95,
    "webformatURL":
        "https://pixabay.com/get/gc429fce6381b02aa23923e2447cfab77a8385eff50ee8882ee9bc6e3bd7d1f0b1c0657774b5cfde8c6e5dc7f8240c7e53ab9af252ce09175001f3391d2475087_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 409,
    "largeImageURL":
        "https://pixabay.com/get/gfe364f34a0b61b4219587f354309bc21629b72c1bc0f7c7daedda8fd8c163a5f8d7652d189a9a595042754d6866f856dc38d1370734c95478f7ee45290b2c13b_1280.jpg",
    "imageWidth": 4752,
    "imageHeight": 3044,
    "imageSize": 5213632,
    "views": 245350,
    "downloads": 138895,
    "collections": 3590,
    "likes": 1028,
    "comments": 159,
    "user_id": 1445608,
    "user": "mploscar",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/01/05/14-08-20-943_250x250.jpg"
  },
];
