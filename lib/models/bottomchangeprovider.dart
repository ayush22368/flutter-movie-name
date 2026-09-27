import 'package:flutter/foundation.dart';

class changeindex extends ChangeNotifier{
  int _currentindex=0;

  void change(int index){
    _currentindex=index;
    notifyListeners();
  }
  int getindex(){
    return _currentindex;
  }
}