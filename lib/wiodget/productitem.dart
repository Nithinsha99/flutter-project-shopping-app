import 'package:flutter/material.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/provider/auth.dart';
import 'package:shoppingapp/provider/cartData.dart';
import 'package:shoppingapp/provider/products.dart';
import 'package:shoppingapp/screens/productDetailsScreen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false);
    final car = Provider.of<Cart>(context, listen: false);
    final carr = Provider.of<Productse>(context);
    final authData=Provider.of<Auth>(context).token;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routerName,
            arguments: product.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Image.network(product.imageUrl),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              product.tittle,
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Products>(
              builder: (ctx, product, _) => IconButton(
                icon: product.favorite
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  product.toogle(authData);
                  print(carr.favoriteItem);
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: () {
                car.addCart(product.id, product.tittle, product.price);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("the product is added"),
                  action: SnackBarAction(label: "undo",onPressed: (){
                    car.removeSingleItem(product.id);
                  },),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
