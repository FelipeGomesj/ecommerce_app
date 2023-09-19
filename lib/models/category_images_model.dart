import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryImagesModel {
  final String id;
  final String? image;
  CategoryImagesModel({
    required this.id,
    required this.image,
  });

  factory CategoryImagesModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CategoryImagesModel(
      id: doc.id,
      image: data['image'] ?? ''
    );
  }
}