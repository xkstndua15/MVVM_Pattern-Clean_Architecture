import 'dart:async';

import '../data/photo_api_repo.dart';
import '../model/photo.dart';

class HomeViewModel {
  final PhotoApiRepo repo;
  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.repo);

  Future<void> fetch(String query) async {
    final result = await repo.fetch(query);
    _photoStreamController.add(result);
  }
}
