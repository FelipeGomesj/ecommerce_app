import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';
import '../models/product_model.dart';
import '../models/shopping_cart_model.dart';
import '../models/user_model.dart';

class ShoppingCartController extends ChangeNotifier {
  ShoppingCartController() {
    loadShoppingCart();
  }

  List<ShoppingCartModel> _shoppingCartList = [];

  List<ShoppingCartModel> get shoppingCartList => _shoppingCartList;
  ShoppingCartModel cartModel = ShoppingCartModel(id: null, productId: null, unitProductPrice: null, amount: null);
  set shoppingCartList(List<ShoppingCartModel>? value){
    shoppingCartList = value;
    notifyListeners();
    print('ShoppingCartController: passou no set shoppingCartList');
  }

  Future<void> loadShoppingCart({UserModel? userModel}) async {
    print('ShoppingCartController: userModel: ${userModel?.id}');
    if (userModel?.id != null && userModel?.id != '') {
      try {
        final QuerySnapshot shoppingCartQuery = await firestore.collection('users').doc(userModel?.id).collection('user_cart').get();
        for (final DocumentSnapshot doc in shoppingCartQuery.docs) {
          if (doc.exists) {
            final cartList = List<Map<String, dynamic>>.from(doc['cart']);

            for (final Map<String, dynamic> cartItem in cartList) {
              final ShoppingCartModel shoppingCartItem = ShoppingCartModel(
                id: doc.id,
                productId: cartItem['productId'],
                unitProductPrice: cartItem['unitProductPrice'],
                amount: cartItem['amount'],
              );
              _shoppingCartList.add(shoppingCartItem);
            }
          }
        }
      } catch (e) {
        print('ShoppingCartController: ERROR AO CONSULTAR CARRINHO: $e');
        //print('ShoppingCartController: _shoppingCartList.length: ${_shoppingCartList.length}');
      }
    }
    //print("ShoppingCartController: shoppingCartList: ${shoppingCartList.length}");
    notifyListeners();
  }

  void addProductToCart({required ProductModel product, required int amount}){
    bool alreadyInCart = false;
    try{
      _shoppingCartList.firstWhere((item) {
        if(product.id == item.productId){
          item.amount = amount;
          alreadyInCart = true;
          return alreadyInCart;
        }else{
          alreadyInCart = false;
          return alreadyInCart;
        }
      });
    }catch(e){
      //print(e);
    }
    if(!alreadyInCart){
      final ShoppingCartModel shoppingCartItem = ShoppingCartModel(id: null, productId: product.id, unitProductPrice: product.price, amount: amount);
      _shoppingCartList.add(shoppingCartItem);
    }
    totalPriceCart();
    notifyListeners();
  }

  Future<void> removeProductToCart({required String productId}) async {
    _shoppingCartList.removeWhere((item){
      if(item.productId == productId && item.amount == 1){
        //print('ShoppingCartController: removeu o produto pq só tinha 1 unidade dele');
        return true;
      }else{
        if(item.productId == productId){
          item.amount = item.amount! - 1;
        }
        //print('ShoppingCartController: decrementou uma unidade');
        return false;
      }
    });
    totalPriceCart();
    notifyListeners();
  }

  void resetCart() {
  _shoppingCartList = [];
  notifyListeners();
}

  void totalPriceCart() {
    num totalPrice = 0;
    for (ShoppingCartModel cartItem in _shoppingCartList) {
      totalPrice += cartItem.totalProductPrice;
    }
    cartModel.totalPriceOfCart = totalPrice;
    //print('cartModel.totalPriceOfCart: ${cartModel.totalPriceOfCart}');
    Future.microtask(() {
      notifyListeners();
    });
  }
}