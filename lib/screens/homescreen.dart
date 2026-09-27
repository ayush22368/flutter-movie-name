import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search_app/models/bottomchangeprovider.dart';
import 'package:movie_search_app/models/moviemodel.dart';
import 'package:movie_search_app/screens/detailsscreen.dart';
import 'package:movie_search_app/screens/searchscreen.dart';
import 'package:provider/provider.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  List<moviemodel>movies=[];
  int movieadder=0;
  Future<void>getmovies()async{

    var response=await http.get(Uri.parse("https://api.tvmaze.com/shows?page=0"));
    var newdata=jsonDecode(response.body);

      for(int i=0;i<31;i++){
        setState(() {
          movies.add(moviemodel.fromjson(newdata[movieadder]));
          movieadder++;



        });
      }




  }
  @override
  void initState() {
    // TODO: implement initState
    getmovies();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 185),
            child: Text("Discover",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 88),
            child: Text("Popular Tv shows from around",style: TextStyle(fontSize: 16,color: Colors.grey),),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 243),
            child: Text("the world",style: TextStyle(fontSize: 16,color: Colors.grey),),
          ),

          Expanded(
            child: movies.isEmpty?Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.all(30),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notication){
                  if(notication.metrics.pixels==notication.metrics.maxScrollExtent){
                    getmovies();
                  }
                  return false;
                },
                child: GridView.builder(
                  itemCount: movies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 270,
                  ),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                
                    return GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>detailscreen(m: movie)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                
                          // POSTER
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                movie.imageurl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                
                          const SizedBox(height: 6),
                
                          // MOVIE NAME
                          Text(
                            movie.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                
                          const SizedBox(height: 3),
                
                          // RATING
                          Text(
                            movie.rating == null
                                ? "No rating"
                                : "⭐ ${movie.rating}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ),
          )
        ],
      )
    );
  }
}
