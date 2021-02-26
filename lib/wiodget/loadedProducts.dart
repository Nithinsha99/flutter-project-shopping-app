import 'package:flutter/material.dart';
import 'package:shoppingapp/provider/products.dart';
import 'package:shoppingapp/screens/editProductScreen.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final  String title;
  final String  imageUrl;
  final String id;
  UserProductItem({this.imageUrl,this.title,this.id});
  @override
  Widget build(BuildContext context) {
    final snackBar=Scaffold.of(context);
    return ListTile(title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routerName,arguments: id);

            }),
            IconButton(icon: Icon(Icons.delete), onPressed: () async{
             try{
              await Provider.of<Productse>(context,listen: false).deleteItem(id);
             } catch(eror){
               snackBar.showSnackBar(SnackBar(content: Text("messge is not delted")));
             }

            })
          ],
        ),
      ),
      
    );
  }
}
