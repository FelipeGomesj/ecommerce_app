// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_app/constants/constants.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../models/category_images_model.dart';
// class CategoryImagesManager extends ChangeNotifier{
//   CategoryImagesManager(){
//     _loadImages();
//   }
//   DocumentSnapshot<Object?>?  _images;
//   //final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   Future<void> _loadImages() async{
//     final DocumentSnapshot _docCategoryImages = await firestore.doc('/images/category_images').get();
//     if(_docCategoryImages.exists){
//       Map<String, dynamic> data = _docCategoryImages.data() as Map<String, dynamic>;
//       CategoryImagesModel categoryImages = CategoryImagesModel.fromDocument(data);
//       print('categoryImages.image: ${categoryImages.image}');
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/category_images_model.dart';

class CategoryImagesManager extends ChangeNotifier {
  List<CategoryImagesModel> _categoryImagesList = [];
  List<CategoryImagesModel> get categoryImagesList => _categoryImagesList;
  CategoryImagesManager(){
    loadCategoryImages();
  }



  Future<void> loadCategoryImages() async {
    try {
      final DocumentSnapshot docSnapshot =
      await firestore.doc('/images/category_images').get();
      if (docSnapshot.exists) {
        final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        final CategoryImagesModel categoryImages = CategoryImagesModel.fromMap(data);
        _categoryImagesList = [categoryImages];
        notifyListeners();
      }
    } catch (error) {
      print("Error loading category images: $error");
    }
  }
}