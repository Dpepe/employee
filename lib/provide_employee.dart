import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AdminProv with ChangeNotifier{
  int _idAdmin = 1;
  String _imgs = "assets/android_rob.jpg";

  int get idAdmin => _idAdmin;
  String get imgs => _imgs;

  void changesOption(int value){
    print(value);
    _idAdmin = value;
    notifyListeners();
    print("****** $_idAdmin");
  }

  void changesOptionImg(String value){
    notifyListeners();
  }
}