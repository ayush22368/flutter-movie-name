import 'package:flutter/material.dart';
import 'package:movie_search_app/models/moviemodel.dart';

class favprovider extends ChangeNotifier{
  List<moviemodel> _favlist=[];

  void add(moviemodel m){
    _favlist.add(m);
    notifyListeners();
  }
  void remove(moviemodel m){
    _favlist.remove(m);
    notifyListeners();
  }
  List<moviemodel> getlist(){
    return _favlist;
  }
}