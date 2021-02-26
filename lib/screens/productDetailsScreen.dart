import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/products.dart';
class ProductDetailScreen extends StatelessWidget {
  static const routerName="/productDetailScreen";

  @override
  Widget build(BuildContext context) {
    final String id=ModalRoute.of(context).settings.arguments as String;
    final loadedProducts=Provider.of<Productse>(context,listen: false).toGetid(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.tittle) ,
      ),
      body: Column(
        children: [
          Container(

            height: 300,
            child: Image.network(loadedProducts.imageUrl,fit: BoxFit.fill,),
          ),
        ],
      ),

    );
  }
}
