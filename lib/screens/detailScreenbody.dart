import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/provider/cartData.dart';
import 'package:shoppingapp/provider/products.dart';


class DetailBody extends StatefulWidget {
  final String id;


  DetailBody(this.id);

  @override
  _DetailBodyState createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  final int  sum=0;
  @override
  Widget build(BuildContext context) {
     final cart=Provider.of<Cart>(context);
    final loadedProducts =
        Provider.of<Productse>(context, listen: false).toGetid(widget.id);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  height: 450,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "PRODUCTS",
                        style: TextStyle(
                          fontFamily: "rock",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        loadedProducts.tittle.toUpperCase(),
                        style: TextStyle(
                          fontFamily: "rock",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.blueGrey,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            "PRICE  ",
                            style: TextStyle(
                              //fontFamily: "rock",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "\$ ${loadedProducts.price} ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Colors.blueGrey,
                                ))
                          ])),
                          Expanded(
                             child:Container(
                               width: 200,
                                height: 200,

                                decoration: BoxDecoration(
                                  color: const Color(0xff7c94b),
                                  image:  DecorationImage(
                                    image: NetworkImage(loadedProducts.imageUrl),
                                    fit: BoxFit.cover

                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,


                      ),
                      Text("products decription"),
                      SizedBox(
                        height: 10,

                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(loadedProducts.decription,style: TextStyle(
                          fontSize: 25,
                          //fontFamily: "rock",
                        ),),
                      ),
                      Container(
                        child: Add(cart: cart, loadedProducts: loadedProducts),

                      )


                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Add extends StatefulWidget {
  const Add({
    Key key,
    @required this.cart,
    @required this.loadedProducts,
  }) : super(key: key);

  final Cart cart;
  final Products loadedProducts;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  bool check=true;
  bool ch;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: Image.network("https://static.thenounproject.com/png/1842086-200.png"), onPressed: (){
          setState(() {
            widget.cart.addCart(widget.loadedProducts.id, widget.loadedProducts.tittle, widget.loadedProducts.price);
            check=false;

          });
        },iconSize: 30,),
        Container(
          width: check?100:150,
          child: check?Text("the quanity of products = ${
          widget.cart.totalAmount
          }"):Container(
            width: 50,
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.add), onPressed: (){
                  widget.cart.addCart(widget.loadedProducts.id, widget.loadedProducts.tittle, widget.loadedProducts.price);
                }),
                IconButton(icon: Icon(Icons.minimize), onPressed: (){
                  widget.cart.removeSingleItem(widget.loadedProducts.id);
                }),
                Text(widget.cart.totalAmount.toString()),
              ],
            )
          )
        )





      ],
    );
  }
}
