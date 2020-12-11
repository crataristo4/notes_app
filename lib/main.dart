import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/pages/homePage.dart';
import 'package:notes_app/services/services.dart';

setUpLocator() {
  //register the service
  GetIt.I.registerLazySingleton(() => NoteServices());
}

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.red,
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}


