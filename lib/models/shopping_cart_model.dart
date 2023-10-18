import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingCartModel {
  ShoppingCartModel({
    required this.id,
    required this.productId,
    required this.unitProductPrice,
    required this.amount,
  });

  final String? id;
  final String? productId;
  final num? unitProductPrice;
  int? amount;
  num get totalProductPrice => (unitProductPrice ?? 0) * (amount ?? 0);
  factory ShoppingCartModel.fromDocument(DocumentSnapshot doc) {
    return ShoppingCartModel(
      id: doc.id,
      productId: doc['productId'],
      unitProductPrice: doc['unitProductPrice'],
      amount: doc['amount'],
    );
  }
}

// class ShoppingCartModel{
//   ShoppingCartModel({
//     required this.id,
//     required this.cart
// });
//   final String id;
//   final List<Map<String, dynamic>> cart;
//
//   factory ShoppingCartModel.fromDocument(DocumentSnapshot doc) =>
//       ShoppingCartModel(id: doc.id, cart: doc['cart']);
// }