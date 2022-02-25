import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:search_image/di/provider_setup.dart';
import 'package:search_image/presentation/home/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: globalProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
