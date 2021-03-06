import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/cartData.dart';
import 'package:shoppingapp/provider/detailsScreen.dart';
import 'package:shoppingapp/wiodget/cartScreenWidget.dart';

class CartScreen extends StatelessWidget {
  static const routerName = "/cartPage";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("the shopping cart"),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  total amount",
                    style: TextStyle(fontSize: 23),
                  ),
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    child: Text(
                      cart.totalAmount.toString(),
                    ),
                  ),
                  falatButton(cart: cart)
                ],
              ),
            ),
          ),
          Text(cart.item.length.toString()),
          Expanded(
            child: ListView.builder(
              itemCount: cart.item.length,
              itemBuilder: (ctx, i) => CartScreenWidget(
                quanity: cart.item.values.toList()[i].quanity,
                productid: cart.item.keys.toList()[i],
                tittle: cart.item.values.toList()[i].tittle,
                id: cart.item.values.toList()[i].id,
                price: cart.item.values.toList()[i].price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class falatButton extends StatefulWidget {

  const falatButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _falatButtonState createState() => _falatButtonState();
}

class _falatButtonState extends State<falatButton> {
  var che=false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed:(widget.cart.totalAmount<=0 || che)?null : () async {
        setState(() {
          che=true;

        });
        print("hello");
        await Provider.of<Orders>(context,listen: false).addOrder(widget.cart.item.values.toList(), widget.cart.totalAmount);

        setState(() {
          che=false;

        });

        widget.cart.clear();

      },

      child: che?CircularProgressIndicator(
        backgroundColor: Colors.red,
      ):Text("Order now "),
      color: Colors.blue,
    );
  }
}
