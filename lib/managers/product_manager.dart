import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class ProductManager extends ChangeNotifier{
  List<ProductModel> _products = [];
  List<ProductModel>  get  products => _products;
  ProductManager(){
    _loadAllProducts();
  }
  Future<void> _loadAllProducts() async{
    try{
      final QuerySnapshot querySnapshot = await firestore.collection('/products').get();
      _products = querySnapshot.docs.map((doc) => ProductModel.fromDocument(doc)).toList();
      notifyListeners();
    }catch(error){
      print("Error loading all Products: $error");
    }
  }
}