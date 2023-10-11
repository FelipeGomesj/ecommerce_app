import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';
import '../models/shopping_cart_model.dart';
import '../models/user_model.dart';

class ShoppingCartController extends ChangeNotifier {
  ShoppingCartController() {
    loadShoppingCart();
  }

  List<ShoppingCartModel> _shoppingCartList = [];

  List<ShoppingCartModel> get shoppingCartList => _shoppingCartList;
  set shoppingCartList(List<ShoppingCartModel>? value){
    shoppingCartList = value;
    notifyListeners();
  }

  Future<void> loadShoppingCart({UserModel? userModel}) async {
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
        print('ERROR AO CONSULTAR CARRINHO: $e');
        print('_shoppingCartList.length: ${_shoppingCartList.length}');
      }
    }
    notifyListeners();
  }
  void resetCart() {
  _shoppingCartList = [];
  notifyListeners();
}

}