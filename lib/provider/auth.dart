import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/models/http_expection.dart';
class Auth with ChangeNotifier{
  String _token;
  String _userId;
  DateTime _experydateTime;
  bool get isAuth{
    return _token!=null;

  }
  String get userid{
    return _userId;
  }
  String get token{
    if(_experydateTime!=null && _experydateTime.isAfter(DateTime.now()) && _token!=null){
      return _token;
    }
    return null;
  }
  Future<void> authData(String password,String email,data) async{
    final  url="https://identitytoolkit.googleapis.com/v1/accounts:$data?key=AIzaSyAdTY4DJ3sxmGmCbBLTwoE1JjlzeEeKH9w";
   try{
     final response=await http.post(url,body: jsonEncode({
       "email":email,
       "password":password,
       "returnSecureToken":true,
     }));
      final eroorMessage=jsonDecode(response.body);
      if(eroorMessage["error"] !=null){
        print(eroorMessage["error"]["message"]);
        throw HttpException(eroorMessage["error"]["message"]);

      }
      _token=eroorMessage["idToken"];
      _userId=eroorMessage["localId"];
      _experydateTime=DateTime.now().add(Duration(seconds: int.parse(eroorMessage["expiresIn"])));
      notifyListeners();
   } catch(error){
     throw error;
     
   }


  }
  Future<void> signUp(String password, String email) async{

     return authData(password, email, "signUp");

  }
  Future<void> login( String password,String email) async{
     return authData(password, email, "signInWithPassword");


  }
}