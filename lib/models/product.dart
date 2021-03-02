import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String tittle;
  final String decription;
  final double price;
  bool favorite;

  Products(
      {this.favorite = false,
      @required this.id,
      @required this.price,
      @required this.tittle,
      @required this.decription,
      @required this.imageUrl}
      );
  void  furure(bool value){
    favorite=value;
    notifyListeners();
  }
  Future<void> toogle(String authDta ,String userId) async{
    var firstValue=favorite;
    favorite=!favorite;
    notifyListeners();
    final url= await "https://shopping-app-28658-default-rtdb.firebaseio.com/userFavorite/$userId/$id.json?auth=$authDta";
   try{
     var reposne=await http.put(url,body: jsonEncode(
       favorite,

     ));
     if(reposne.statusCode>=400){
       furure(firstValue);

     }
   }catch(eror){
     print(eror);
     furure(firstValue);
   }


  }
}
