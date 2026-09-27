import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
class moviemodel{
  String name;
  String? rating;
  List<dynamic>gene;
  String summary;
  String imageurl;
  bool isadded;
  moviemodel({required this.name,required this.rating,required this.gene,required this.summary,required this.imageurl,required this.isadded});

  factory moviemodel.fromjson(Map<String,dynamic>json){
      return moviemodel(name: json["name"], rating: json["rating"]["average"]?.toString(), gene: json["genres"], summary: html_parser.parse(json['summary'] ?? '').body?.text ?? '', imageurl: json["image"]["original"],isadded: false);
  }
}
// List<moviemodel>movies=[];
//
// Future<void>get_data()async{
//   var response=await http.get(Uri.parse("https://api.tvmaze.com/shows?page=0"));
//   var newresponse=jsonDecode(response.body);
//
//   for(var ks in newresponse){
//     movies.add(moviemodel.fromjson(ks));
//     if(movies.length==300){
//       break;
//     }
//   }
// }
// void main()async{
//   await get_data();
//   for(int i=0;i<300;i++){
//     print("${i+1}. ${movies[i].name}. ${movies[i].summary}. ${movies[i].gene}. ${movies[i].rating}");
//   }
// }