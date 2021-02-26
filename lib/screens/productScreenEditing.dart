import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/provider/products.dart';
import 'package:shoppingapp/screens/editProductScreen.dart';
import 'package:shoppingapp/wiodget/drawer.dart';
import 'package:shoppingapp/wiodget/loadedProducts.dart';


class UserProductScreen extends StatelessWidget {
  static const routerName="/userProduct";
  Future<void> loadedProductss(BuildContext context)async{
    await Provider.of<Productse>(context).toFetchData();

}
  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of<Productse>(context);
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routerName);
          })
        ],
      ),
      drawer: DrawerScreen(),
      body: RefreshIndicator(
        onRefresh: ()=> loadedProductss(context),
        child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: ListView.builder(itemCount: loadedProducts.item.length,
                itemBuilder: (_, index) =>
                    Column(
                      children: [
                        UserProductItem(title: loadedProducts.item[index].tittle,
                          imageUrl: loadedProducts.item[index].imageUrl,
                          id: loadedProducts.item[index].id,
                        ),
                        Divider()
                      ],
                    ),)
        ),
      ),
    );
  }
}
