import 'package:flutter/material.dart';
import 'package:flutter_note/di/provider_setup.dart';
import 'package:flutter_note/presentation/notes/notes_screen.dart';
import 'package:flutter_note/ui/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final providers = await getProviders();

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        primaryColor: Colors.white,
        backgroundColor: darkGrey,
        canvasColor: darkGrey,
        floatingActionButtonTheme: Theme.of(context)
            .floatingActionButtonTheme
            .copyWith(backgroundColor: Colors.white, foregroundColor: darkGrey),
        appBarTheme:
            Theme.of(context).appBarTheme.copyWith(backgroundColor: darkGrey),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      home: const NotesScreen(),
    );
  }
}
