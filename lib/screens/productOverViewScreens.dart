import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/provider/cartData.dart';
import 'package:shoppingapp/provider/products.dart';
import 'package:shoppingapp/screens/cartScreen.dart';
import 'package:shoppingapp/wiodget/badgets.dart';
import 'package:shoppingapp/wiodget/drawer.dart';
import 'package:shoppingapp/wiodget/product_grid.dart';
import 'package:shoppingapp/wiodget/productitem.dart';

enum FilterOption {
  Favorite,
  ShowAll,
}

class ProductOverScreen extends StatefulWidget {
  static const rouuterName="/over screen";
  @override
  _ProductOverScreenState createState() => _ProductOverScreenState();
}

class _ProductOverScreenState extends State<ProductOverScreen> {
  var _ShowOnlyFavorite = false;
  var initStatee=true;
  @override
  void didChangeDependencies() {
    if(initStatee){
      Provider.of<Productse>(context).toFetchData();

    }
    initStatee=false;

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("the shop ap"),
        actions: [
          PopupMenuButton(icon: Icon(Icons.more_vert),
              onSelected: (FilterOption onSelected) {
                setState(() {
                  if (FilterOption.Favorite == onSelected) {
                    _ShowOnlyFavorite = true;
                  } else {
                    _ShowOnlyFavorite = false;
                  }
                });
              },
              itemBuilder: (_) =>
              [

                PopupMenuItem(child: Text("Favorite Screen"),
                  value: FilterOption.Favorite,
                ),
                PopupMenuItem(child: Text("The full Show"),
                  value: FilterOption.ShowAll,
                ),


              ]),
          Consumer<Cart>(

              builder: (_, cart, __) =>
                  Badges(child: IconButton(
                    icon: Icon(Icons.shopping_cart), onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routerName);
                  },),
                    value: cart.cartCount.toString(),

                  ),


          ),
        ],

      ),
      drawer: DrawerScreen(),
      body: ProductGrid(_ShowOnlyFavorite),
    );
  }
}