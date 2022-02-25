import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;
import 'package:search_image/data/data_source/pixabay_api.dart';
import 'package:search_image/data/repository/photo_api_repo_impl.dart';
import 'package:search_image/domain/model/repository/photo_api_repo.dart';
import 'package:search_image/domain/use_case/get_photos_use_case.dart';
import 'package:search_image/presentation/home/home_view_model.dart';

//1. Provider 전체
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...depencentModels,
  ...viewModels
];

//2. 의존성 없는 class
List<SingleChildWidget> independentModels = [
  Provider<http.Client>(
    create: (context) => http.Client(),
  ),
];

//3. 2번에 의존하는 class
List<SingleChildWidget> depencentModels = [
  ProxyProvider<http.Client, PixabayApi>(
      update: (context, client, _) => PixabayApi(client)),
  ProxyProvider<PixabayApi, PhotoApiRepo>(
      update: (context, api, _) => PhotoApiRepositoryApiImpl(api)),
  ProxyProvider<PhotoApiRepo, GetPhotosUseCase>(
      update: (context, repo, _) => GetPhotosUseCase(repo))
];

//4. ViewModels
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(context.read<GetPhotosUseCase>()))
];
