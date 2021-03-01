import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoppingapp/models/http_expection.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:http/http.dart' as http;

class Productse with ChangeNotifier {
  List<Products> _item = [
   /* Products(
      id: "1",
      price: 230,
      tittle: "Dress",
      decription: "for wearing trends",
      imageUrl:
      "https://img2.exportersindia.com/product_images/bc-full/dir_136/4051585/shirt-1487763641-2733442.jpeg",
    ),
    Products(
      id: "2",
      price: 550,
      tittle: "fryPan",
      decription: "for using cooking",
      imageUrl:
      "https://www.bigbasket.com/media/uploads/p/l/40186127-2_1-prestige-omega-deluxe-granite-200-mm-fry-pan-wo-lid-36304.jpg",
    ),
    Products(
      id: "3",
      price: 1000,
      tittle: "fryPan",
      decription: "trousers",
      imageUrl:
      "https://contents.mediadecathlon.com/p1484188/5438e477470743c553e02131c9f0a754/p1484188.jpg?f=650x650",
    ),
    Products(
      id: "4",
      price: 400,
      tittle: "chappals",
      decription: "for wearing foot",
      imageUrl:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpjrDtt4U-D4C1QQYZbEjDLK5CZ0QHWMJ3KA&usqp=CAU",
    ),*/
  ];
  final String authToken;
  Productse(this.authToken,this._item);

  List<Products> get item {
    return [..._item];
  }

  List<Products> get favoriteItem {
    return _item.where((element) => element.favorite).toList();
  }

  Products toGetid(String id) {
    return _item.firstWhere((element) => id == element.id);
  }

  Future<void> updateProduct(String id, Products products)async {
    final proIndex = _item.indexWhere((element) => element.id == id);
    if (proIndex >= 0) {
      final url= "https://shopping-app-28658-default-rtdb.firebaseio.com/products/$id.json";
      await http.patch(url,body: json.encode({
        "tittle": products.tittle,
        "decription": products.decription,
        "imageurl": products.imageUrl,
        "favorite": products.favorite,
        "price": products.price,


      }));
      _item[proIndex] = products;
      notifyListeners();
    } else {
      print("....");
    }
  }

  Future<void> toFetchData() async {
    final url = "https://shopping-app-28658-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    try {
      final response = await http.get(url);

      var loadedPrducts = jsonDecode(response.body) as Map<String, dynamic>;
      final List <Products> ecahItem = [];
      if(loadedPrducts==null){
        return;
      }
      loadedPrducts.forEach((id1, productDet) {
        ecahItem.add(Products(id: id1,
            price: productDet["price"],
            tittle: productDet["tittle"],
            decription: productDet["decription"],
            imageUrl: productDet["imageurl"]));
      });
      _item=ecahItem;
      notifyListeners();
    } catch (eroor) {
      print(eroor);
      throw eroor;

    }
  }

  Future <void> addProduct(Products products) async {
    const  url = "https://shopping-app-28658-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.post(url, body: json.encode({
        "tittle": products.tittle,
        "decription": products.decription,
        "imageurl": products.imageUrl,
        "favorite": products.favorite,
        "price": products.price,

      }));
      print(json.decode(response.body));
      final productse = Products(
          id: json.decode(response.body)["name"],

          price: products.price,
          tittle: products.tittle,
          decription: products.decription,
          imageUrl: products.imageUrl);
      _item.add(productse);
      notifyListeners();
    } catch (eroor) {
      throw eroor;
    }
  }


  Future<void>deleteItem(String id) async {
    var url = "https://shopping-app-28658-default-rtdb.firebaseio.com/products/$id.json";
    final index=_item.indexWhere((element) => element.id==id);
    var loadingProducts=_item[index];
    _item.removeAt(index);
    notifyListeners();
    var response=await http.delete(url);
      if(response.statusCode>=400){
        _item.insert(index, loadingProducts);
        notifyListeners();
        throw  HttpException("world n ot delte");
      }
      loadingProducts=null;


    }


}
