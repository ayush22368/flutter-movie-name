import 'package:flutter/material.dart';
import 'package:movie_search_app/models/bottomchangeprovider.dart';
import 'package:movie_search_app/screens/favouritescree.dart';
import 'package:movie_search_app/screens/homescreen.dart';
import 'package:movie_search_app/screens/searchscreen.dart';
import 'package:provider/provider.dart';

class bottomscreen extends StatefulWidget {
  const bottomscreen({super.key});

  @override
  State<bottomscreen> createState() => _bottomscreenState();
}

class _bottomscreenState extends State<bottomscreen> {

  final screens=[
    homescreen(),
    searchscreen(),
    favourite()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFF5A4CF5),
          unselectedItemColor: Colors.grey,
          currentIndex: context.watch<changeindex>().getindex(),

         backgroundColor: Colors.black,
          onTap: (index){

               context.read<changeindex>().change(index);

          },
          items: [

        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favourite")
      ]),
      body: screens[context.watch<changeindex>().getindex()],
    );
  }
}
