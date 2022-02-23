import 'package:flutter/material.dart';
import 'package:search_image/data/pixabay_api.dart';
import 'package:search_image/ui/home_screen.dart';
import 'package:search_image/ui/home_view_model.dart';

import 'data/photo_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotoProvider(
        child: const HomeScreen(),
        homeViewModel: HomeViewModel(PixabayApi()),
      ),
    );
  }
}
