import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search_app/models/moviemodel.dart';
import 'package:movie_search_app/screens/detailsscreen.dart';
class searchscreen extends StatefulWidget {
  const searchscreen({super.key});

  @override
  State<searchscreen> createState() => _searchscreenState();
}

class _searchscreenState extends State<searchscreen> {
  TextEditingController controller=TextEditingController();
  List<moviemodel>?results=[];
  Future<List<moviemodel>?> getmovie(String text)async{
    List<moviemodel>types=[];
    var response=await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=$text"));
    var newdata=jsonDecode(response.body);
    for(var ks in newdata){
      setState(() {
        types.add(moviemodel.fromjson(ks["show"]));
      });
    }
    if(types.isEmpty){
      return null;
    }
    else{
      return types;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    controller.addListener((){
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          SizedBox(
            height: 60,
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                color: Color(0xFF141F2C),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: controller,

                  decoration: InputDecoration(
                    hintText: "Search movie",
                    prefixIcon: IconButton(onPressed: ()async{
                      List<moviemodel>? kite=await getmovie(controller.text);
                      if(kite==null){
                        setState(() {
                          results=null;
                        });
                      }
                      else{
                        setState(() {
                          results=kite;
                        });
                      }
                    }, icon: Icon(Icons.search,color: Colors.grey,)),
                    suffixIcon: controller.text.isNotEmpty?IconButton(onPressed: (){
                      setState(() {
                        controller.text="";
                        results!.clear();
                      });
                    }, icon: Icon(Icons.cancel,color: Colors.grey,)):null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                    )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: results == null
                ? const Center(
              child: Text(
                "no movie found",
                style: TextStyle(color: Colors.white),
              ),
            )
                : ListView.builder(
              itemCount: results!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 33,
                    vertical: 7,
                  ),
                  child: Row(
                    children: [
                      // Poster
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          results![index].imageurl,
                          height: 90,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Name + rating
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              results![index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),

                            // Only show rating if it exists
                            if (results![index].rating != null) ...[
                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    results![index].rating!,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      // const Icon(
                      //   Icons.chevron_right,
                      //   color: Colors.grey,
                      //   size: 24,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>detailscreen(m: results![index])));
                        }, icon: Icon(Icons.chevron_right,color: Colors.grey,size: 30,)),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
