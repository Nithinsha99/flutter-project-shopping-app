import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/cartData.dart';
import 'package:shoppingapp/provider/products.dart';
import 'package:shoppingapp/screens/cartScreen.dart';
import 'package:shoppingapp/screens/detailScreenbody.dart';
import 'package:shoppingapp/wiodget/badgets.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routerName = "/productDetailScreen";

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    final co=[
      Color(0xffcc9e9b),
      Color(0xffc5e3d9),
      Color(0xffded3e6),
      Color(0xff1af0f0),
      Color(0xffdfedc0),
      Color(0xfff5e9c1)

    ];
    var col=Random().nextInt(co.length);


    return Scaffold(
      backgroundColor: co[col],

      appBar: AppBar(
        backgroundColor: co[col],
        actions: [
          Consumer<Cart>(
            builder: (_, cart, __) => Badges(
              child: IconButton(
                icon: Image.network("https://static.thenounproject.com/png/1842086-200.png"),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routerName);
                },
              ),
              value: cart.cartCount.toString(),
            ),
          )
        ],

      ),
      body: DetailBody(id),
    );
  }
}
