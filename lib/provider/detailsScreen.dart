import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/provider/cartData.dart';
import 'package:http/http.dart' as htpp;

class OrderItem {
  final String id;
  final List<CartItem> products;
  final double amount;
  final DateTime dateTime;

  OrderItem({this.dateTime, this.id, this.amount, this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
  }
  final String authToken;
  Orders(this.authToken,this._order);
  Future <void> fetchingData()async{
    final url = "https://shopping-app-28658-default-rtdb.firebaseio.com/order.json?auth=$authToken";
    var reponse= await htpp.get(url);
    final List <OrderItem> fetchCointent=[];
    final fetchData=json.decode(reponse.body) as Map<String,dynamic>;
    if(fetchingData()==null){
      return;
    }
    fetchData.forEach((key, product) {
      fetchCointent.add(
        OrderItem(
          id: key,
          dateTime: DateTime.parse(product["dateTime"]),
          amount: product["total"],
          products: (product["products"] as List<dynamic>).map((e) =>CartItem(
            price: e["price"],
            quanity: e["quanity"],
            tittle: e["title"],
              id: e["id"],
          )).toList(),

        ),

      );
      _order=fetchCointent;
      notifyListeners();


    });
    
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = "https://shopping-app-28658-default-rtdb.firebaseio.com/order.json?auth=$authToken";
    print("to check");

    var finall = DateTime.now();
    try{
      final response= await htpp.post(
        url,
        body: json.encode({
          "total": total,
          "dateTime": finall.toIso8601String(),
          "products": cartProducts
              .map((e) => {
            "id":e.id,
            "price": e.price,
            "quanity": e.quanity,
            "title": e.tittle,
          })
              .toList(),
        }),
      );
      _order.insert(
        0,
        OrderItem(
            id: json.decode(response.body)["name"],
            products: cartProducts,
            amount: total,
            dateTime: DateTime.now()),
      );
      notifyListeners();
    }catch(eror){
      print(eror);
    }

    print("to check");


  }
}
