import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/detailsScreen.dart'show Orders;
import 'package:shoppingapp/wiodget/drawer.dart';
import 'package:shoppingapp/wiodget/orderItem.dart';

class OrdersScreen extends StatelessWidget {
  static const routerName = "order";

  @override
  Widget build(BuildContext context) {
    print("heloo");
   // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("our oders"),
      ),
      drawer: DrawerScreen(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context,listen: false).fetchingData(),
        builder: (ctx,snapShot){
         if( snapShot.connectionState==ConnectionState.waiting){
           print("waitinh");
           return Center(
             child: Container(
               color: Colors.red,
               child: CircleAvatar(),
             ),
           );
         }else{
           if(snapShot.error!=null){
             return Center(child: Text("print the Erorr"));
           }else{
             print("hello");
             return Consumer<Orders>(builder:(ctx,orderData,child) =>
               ListView.builder(
                 itemCount: orderData.order.length,
                 itemBuilder: (ctx, i) => OrderItems(
                   orders: orderData.order[i],
                 ),
               ),
             );

           }

         }
        },


      ),
    );
  }
}
