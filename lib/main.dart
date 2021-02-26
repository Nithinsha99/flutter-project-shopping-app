import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/auth.dart';
import 'package:shoppingapp/provider/cartData.dart';
import 'package:shoppingapp/provider/detailsScreen.dart';
import 'package:shoppingapp/provider/products.dart';
import 'package:shoppingapp/screens/authScreen.dart';
import 'package:shoppingapp/screens/cartScreen.dart';
import 'package:shoppingapp/screens/editProductScreen.dart';
import 'package:shoppingapp/screens/orderScreens.dart';
import 'package:shoppingapp/screens/productDetailsScreen.dart';
import 'package:shoppingapp/screens/productOverViewScreens.dart';
import 'package:shoppingapp/screens/productScreenEditing.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [

        ChangeNotifierProvider(
        create: (ctx)=>Productse(),
        ),
        ChangeNotifierProvider(
        create: (ctx)=>Cart(),
        ),
     ChangeNotifierProvider(create: (ctx)=>Orders()),
      ChangeNotifierProvider(create: (ctx)=>Auth(),)

    ],
      child: MaterialApp(
          theme: ThemeData( 
            primarySwatch: Colors.orange,
            accentColor: Colors.white,
          ),
          home: AuthScreen(),

          routes: {
            ProductOverScreen.rouuterName:(context)=>ProductOverScreen(),
            ProductDetailScreen.routerName:(ctx)=>ProductDetailScreen(),
            CartScreen.routerName:(ctx)=>CartScreen(),
            OrdersScreen.routerName:(ctx)=>OrdersScreen(),
            UserProductScreen.routerName:(ctx)=>UserProductScreen(),
            EditProductScreen.routerName:(ctx)=>EditProductScreen(),
            AuthScreen.routerName:(ctx)=>AuthScreen(),
          },
        ),
    );

  }
}

