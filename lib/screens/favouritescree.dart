import 'package:flutter/material.dart';
import 'package:movie_search_app/models/favprovider.dart';
import 'package:movie_search_app/models/moviemodel.dart';
import 'package:movie_search_app/screens/detailsscreen.dart';
import 'package:provider/provider.dart';

class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  @override
  Widget build(BuildContext context) {
    List<moviemodel> favdata = context.watch<favprovider>().getlist();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text(
              "Favorites",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: Text(
              "Your saved shows",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child:
                favdata.isEmpty
                    ? Center(child: Text("no data added",style: TextStyle(fontSize: 17,color: Colors.white),))
                    : ListView.builder(
                      itemCount: favdata.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>detailscreen(m: favdata[index])));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 180,
                              width: 370,
                              decoration: BoxDecoration(
                                color: Color(0xFF141F2C),
                                borderRadius: BorderRadius.circular(10)
                              ),

                              child: Row(
                                children: [
                                  ClipRRect(borderRadius:BorderRadius.circular(10), child: Image.network(favdata[index].imageurl,fit: BoxFit.contain,)),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 14),
                                          child: Text(favdata[index].name,maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w200,),),
                                        ),
                                        favdata[index].rating!=null?Padding(padding: EdgeInsets.only(right: 50), child : Text("⭐${favdata[index].rating}",style: TextStyle(fontSize: 18,color: Colors.white),)):Text("No rating",style: TextStyle(fontSize: 17,color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 29,
                                  ),
                                  IconButton(onPressed: (){
                                    context.read<favprovider>().remove(favdata[index]);
                                  }, icon: Icon(Icons.favorite,color: Colors.red,size: 35,))
                                ],
                              ),

                            ),

                          ),

                        );

                      },
                    ),

          ),
        ],
      ),
    );
  }
}
