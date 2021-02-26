import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/detailsScreen.dart' as ord;
import 'package:intl/intl.dart';

class OrderItems extends StatefulWidget {
  final ord.OrderItem orders;

  OrderItems({this.orders});

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
                DateFormat("dd/mm/yyyy, hh:mm").format(widget.orders.dateTime)),
            leading: Text(widget.orders.amount.toString()),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          if (_expand)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: min(widget.orders.products.length * 20.0 + 80, 100),
              child: ListView(
                  children: widget.orders.products
                      .map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.tittle,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${e.quanity} x ${e.price.toString()}",
                                style: TextStyle(
                                  fontSize: 15,

                                ),
                              )
                            ],
                          ),).toList()),

            )
        ],
      ),
    );
  }
}
