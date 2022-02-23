import 'dart:convert';

import 'package:search_image/data/photo_api_repo.dart';

import '../model/photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi implements PhotoApiRepo {
  final baseUrl = 'https://pixabay.com/api/';
  final key = '25837932-733d3bf0fe44ae0ffa17a2862';

  @override
  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(
        Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    Iterable hits = jsonResponse['hits'];

    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
