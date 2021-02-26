import 'package:flutter/foundation.dart';
class CartItem{
  final String id;
  final String tittle;
  final int quanity;
  final double price;
  CartItem({this.id,this.tittle,this.price,this.quanity});
}

class Cart with ChangeNotifier{
  Map<String,CartItem>_item={};
  Map<String,CartItem> get item{
    return
        {..._item};
  }

  void addCart(String productId,String tittle,double price){
    if(_item.containsKey(productId)){
      _item.update(productId, (value) => CartItem(tittle: value.tittle,quanity: value.quanity +1,price: value.price,id: value.id));

    }else{
      _item.putIfAbsent(productId, () => CartItem(id: DateTime.now().toString(),tittle: tittle,price: price,quanity: 1));
    }
    notifyListeners();
  }
  double  get totalAmount{
    double total=0.0;
    _item.forEach((key, to) {
      total=total+to.price *to.quanity;
    });
    return
        total;


  }

  int get cartCount{
    return
        _item.length;

  }
  void removeItem(String productId){
    _item.remove(productId);
    notifyListeners();
  }
  void clear(){
    _item={};
    notifyListeners();
  }
  void removeSingleItem(String productkey){
    if(!_item.containsKey(productkey)){
      return;
    }
    if(_item[productkey].quanity >1){
      _item.update(productkey, (value) => CartItem(id: value.id,quanity: value.quanity-1,price: value.price,tittle: value.tittle));
    }else{
      _item.remove(productkey);
    }
    notifyListeners();
  }


}
