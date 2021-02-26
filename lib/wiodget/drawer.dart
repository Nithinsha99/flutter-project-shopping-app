import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/orderScreens.dart';
import 'package:shoppingapp/screens/productDetailsScreen.dart';
import 'package:shoppingapp/screens/productScreenEditing.dart';
class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("hello"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Text("homepage"),
            trailing: IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed("/");
              },
            ),
          ),
          Divider(

          ),
          ListTile(
            leading: Text("Payments"),
            trailing: IconButton(
              icon: Icon(Icons.payments),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(OrdersScreen.routerName);
              },
            ),
          ),
          ListTile(
            leading: Text("MangeProucts"),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(UserProductScreen.routerName);
              },
            ),
          ),

        ],
      ),
    );
  }
}
