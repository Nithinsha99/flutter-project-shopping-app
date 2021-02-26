import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routerName = "/editProduct";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _focusNode = FocusNode();
  final _decriptionnode = FocusNode();
  final _controller = TextEditingController();
  final _imageUrl = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editingItem =
      Products(id: null, price: 0, tittle: "", decription: "", imageUrl: " ");
  var _intialState = true;
  var _initValue = {
    "title": "",
    "price": "",
    "decription": "",
    "imageUrl": "",
  };
  var change=false;

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrl.removeListener((updateLister));
    _focusNode.dispose();
    _decriptionnode.dispose();
    _controller.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrl.addListener((updateLister));
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_intialState) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editingItem = Provider.of<Productse>(context).toGetid(productId);
        _initValue = {
          "title": _editingItem.tittle,
          "price": _editingItem.price.toString(),
          "imageUrl": "",
          "decription": _editingItem.decription,
        };
        _controller.text = _editingItem.imageUrl;
      }
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void updateLister() {
    if (!_imageUrl.hasFocus) {
      if ((!_controller.text.startsWith("http")) &&
              (!_controller.text.startsWith("htpps")) ||
          (_controller.text.isEmpty)) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> save() async {
    var validate = _form.currentState.validate();
    if (!validate) {
      return;
    }
    _form.currentState.save();
    setState(() {
      change=true;
    });
    if (_editingItem.id != null) {
    await  Provider.of<Productse>(context, listen: false).updateProduct(_editingItem.id, _editingItem);



    } else {
      try{
        await Provider.of<Productse>(context, listen: false).addProduct(_editingItem);
      }catch(eroor){
       await showDialog(context: context,
            builder: (ctx)=>AlertDialog(
              title: Text("you have eroor occupered"),
              content: Text("in valid eroor or invalid input"),
              actions: [
                FlatButton(onPressed: (){
                  Navigator.of(ctx).pop();

                }, child: Text("ok"))
              ],
            )
        );
      }


    }
    setState(() {
      Navigator.of(context).pop();
      change=false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add product Screen"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                save();
              })
        ],
      ),
      body: change?Center(child: CircularProgressIndicator(),):Padding(
        padding: const EdgeInsets.all(11.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValue["title"],
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                onSaved: (value) {
                  _editingItem = Products(
                      id: _editingItem.id,
                      price: _editingItem.price,
                      tittle: value,
                      decription: _editingItem.decription,
                      imageUrl: _editingItem.imageUrl,
                    favorite: _editingItem.favorite,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "enter the details";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValue["price"],
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _focusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_decriptionnode);
                },
                onSaved: (value) {
                  _editingItem = Products(
                      id: _editingItem.id,
                      price: double.parse(value),
                      tittle: _editingItem.tittle,
                      decription: _editingItem.decription,
                      imageUrl: _editingItem.imageUrl,
                    favorite: _editingItem.favorite,

                  );
                },
                validator: (value) {
                  if (double.tryParse(value) == null) {
                    return "enter the valid price";
                  }
                  if (value.isEmpty) {
                    return "enter the price";
                  }
                  if (double.parse(value) <= 0) {
                    return "enter the price is greater amount";
                  } else
                    return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Decription"),
                initialValue: _initValue["decription"],
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _decriptionnode,
                onSaved: (value) {
                  _editingItem = Products(
                      id: _editingItem.id,
                      price: _editingItem.price,
                      tittle: _editingItem.tittle,
                      decription: value,
                      imageUrl: _editingItem.imageUrl,
                    favorite: _editingItem.favorite,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "the value is empty";
                  }
                  if (value.length < 10) {
                    return "the enter the charcte above 10";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 120,
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    decoration: BoxDecoration(border: Border.all(width: 7)),
                    child: _controller.text.isEmpty
                        ? Text("enter the text")
                        : FittedBox(
                            child: Image.network(
                            _controller.text,
                            fit: BoxFit.fill,
                          )),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "enter the url"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _controller,
                      focusNode: _imageUrl,
                      onFieldSubmitted: (_) {
                        save();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter the value";
                        }
                        if ((!value.startsWith("http")) &&
                            (!value.startsWith("https"))) {
                          return "enter the valid url";
                        } else
                          return null;
                      },
                      onSaved: (value) {
                        _editingItem = Products(
                            id: _editingItem.id,
                            price: _editingItem.price,
                            tittle: _editingItem.tittle,
                            decription: _editingItem.decription,
                            imageUrl: value,
                          favorite: _editingItem.favorite,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
