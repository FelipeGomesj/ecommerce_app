import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel(
      {required this.images,
        required this.name,
        required this.price,
        required this.id,
        required this.description});

  String? id;
  List<String>? images;
  String? description;
  String? name;
  num? price;
  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
        id: doc.id,
        description: doc["description"],
        images: List<String>.from(doc["images"]),
        name: doc["name"],
        price: doc["price"]);
  }
}
