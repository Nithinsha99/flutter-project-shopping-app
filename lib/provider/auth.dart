import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier{
  String _token;
  String _userId;
  DateTime _dateTime;
  Future<void> signUp(String password, String email) async{


    const  url="https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAdTY4DJ3sxmGmCbBLTwoE1JjlzeEeKH9w";
    final response=await http.post(url,body: jsonEncode({
      "email":email,
      "password":password,
      "returnSecureToken":true,
    }));
    print(jsonDecode(response.body));
    print("hello");

  }
}