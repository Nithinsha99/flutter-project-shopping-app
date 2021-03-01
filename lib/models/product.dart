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
  Future<void> toogle(String authDta) async{
    var firstValue=favorite;
    favorite=!favorite;
    notifyListeners();
    var url= await "https://shopping-app-28658-default-rtdb.firebaseio.com/products/$id.json?auth=$authDta";
   try{
     var reposne=await http.patch(url,body: jsonEncode({
       "favorite":favorite

     }));
     if(reposne.statusCode>=400){
       furure(firstValue);

     }
   }catch(eror){
     furure(firstValue);
   }


  }
}
