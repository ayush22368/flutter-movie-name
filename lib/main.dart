import 'package:flutter/material.dart';
import 'package:movie_search_app/models/bottomchangeprovider.dart';
import 'package:movie_search_app/models/favprovider.dart';
import 'package:movie_search_app/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context)=>changeindex()),ChangeNotifierProvider(create: (context)=>favprovider())],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:splashscreen(),
    );
  }
}

