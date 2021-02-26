import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/provider/products.dart';
import 'package:shoppingapp/wiodget/productitem.dart';
class ProductGrid extends StatelessWidget {
  final bool showOfFavorite;
  ProductGrid(this.showOfFavorite);
  @override

  Widget build(BuildContext context) {
   final provide= Provider.of<Productse>(context);
   final loadedProducts=showOfFavorite?provide.favoriteItem:provide.item;
   print(loadedProducts);


    return  GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],

        child: ProductItem(
         // imageUrl: loadedProducts[index].imageUrl,
         //  tittle: loadedProducts[index].tittle,
         //  price: loadedProducts[index].price,
         //  id: loadedProducts[index].id,
        ),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
