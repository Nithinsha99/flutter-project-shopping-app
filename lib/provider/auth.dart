import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/models/http_expection.dart';
class Auth with ChangeNotifier{
  String _token;
  String _userId;
  DateTime _dateTime;
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