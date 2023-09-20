import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryImagesModel {
  final String id;
  final String? image;
  final String? category;
  CategoryImagesModel({
    required this.id,
    required this.image,
    required this.category
  });

  factory CategoryImagesModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CategoryImagesModel(
      id: doc.id,
      image: data['image'] ?? '',
      category: data["category"]
    );
  }
}