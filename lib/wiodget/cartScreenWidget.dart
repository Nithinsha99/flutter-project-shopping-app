import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/cartData.dart';
class CartScreenWidget extends StatelessWidget {
  final String id;
  final String tittle;
  final int quanity;
  final double price;
  final String productid;
  CartScreenWidget({this.quanity,this.price,this.tittle,this.id,this.productid});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete,size: 30,color: Colors.white,),
        alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 10),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productid);

      },
      confirmDismiss: (direction){
        return
            showDialog(context: context,
            builder: (ctx)=>AlertDialog(
              title: Text("are you sure"),
              content: Text("you want to remove the item"),
              actions: [
                FlatButton(
                  child: Text("yes"),
                  onPressed: (){
                    Navigator.of(ctx).pop(true);
                  },
                ),
                FlatButton(
                  child: Text("no"),
                  onPressed: (){
                    Navigator.of(ctx).pop(false);
                  },
                ),

              ],
            ));
      },
      child: Card(
        child: ListTile(
          leading:Text(tittle) ,
          subtitle: Text(price.toString()),
          trailing: Text("x $quanity"),
          title: Text("amount is ${quanity*price}"),
        ),
      ),
    );
  }
}
