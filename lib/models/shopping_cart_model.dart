// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ShoppingCartModel {
//   ShoppingCartModel({
//     required this.id,
//     required this.productId,
//     required this.unitProductPrice,
//     required this.amount,
//   });
//
//   final String? id;
//   final String? productId;
//   final num? unitProductPrice;
//   int? amount;
//   num get totalProductPrice => (unitProductPrice ?? 0) * (amount ?? 0); //preço total de cada produto referente a sua quantidade
//   num? totalPriceOfCart;  //preço total de todos os produtos presente no carrinho.
//
//   factory ShoppingCartModel.fromDocument(DocumentSnapshot doc) {
//     return ShoppingCartModel(
//       id: doc.id,
//       productId: doc['productId'],
//       unitProductPrice: doc['unitProductPrice'],
//       amount: doc['amount'],
//     );
//   }
// }
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
  num? totalPriceOfCart;


  factory ShoppingCartModel.fromDocument(DocumentSnapshot doc) {
    return ShoppingCartModel(
      id: doc.id,
      productId: doc['productId'],
      unitProductPrice: doc['unitProductPrice'],
      amount: doc['amount'],
    );
  }
}