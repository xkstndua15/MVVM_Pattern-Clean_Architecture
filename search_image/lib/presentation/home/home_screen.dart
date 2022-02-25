import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image/presentation/home/components/photo_widget.dart';

import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<HomeViewModel>();

      _subscription = viewModel.eventStream.listen((event) {
        event.when(showSnackBar: (msg) {
          final snackBar = SnackBar(
            content: Text(msg),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final state = homeViewModel.state;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('이미지 검색 앱', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            homeViewModel.fetch(_controller.value.text);
                          }))),
            ),
            state.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                    itemBuilder: (context, index) {
                      final photo = state.photos[index];
                      return PhotoWidget(photo: photo);
                    },
                    itemCount: state.photos.length,
                  ))
          ],
        ));
  }
}
