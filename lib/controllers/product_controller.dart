import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class ProductController extends ChangeNotifier{
  List<ProductModel> _products = [];
  List<ProductModel>  get  products => _products;
  ProductController(){
    loadAllProducts();
  }
  Future<void> loadAllProducts() async{
    try{
      final QuerySnapshot querySnapshot = await firestore.collection('/products').get();
      _products = querySnapshot.docs.map((doc) => ProductModel.fromDocument(doc)).toList();
      notifyListeners();
    }catch(error){
      print("Error loading all Products: $error");
    }
  }
  List<ProductModel> listCategoryProducts(String category){
    // final _productManager = Provider.of<ProductManager>(context);
    // final _productList = _productManager.products;
    List<ProductModel> productCategoryList = [];
    for(ProductModel product in products) {
      if(product.type == category){
        productCategoryList.add(product);
      }
    }
    return productCategoryList;
  }

}