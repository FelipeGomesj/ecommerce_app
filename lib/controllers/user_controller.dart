import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controllers/shopping_cart_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_helper/firebase_errors.dart';
import '../models/user_model.dart';

class UserController extends ChangeNotifier {

  UserController(){
    _loadCurrentUser();
  }

  UserModel? userModel;
  ShoppingCartController shoppingCartController = ShoppingCartController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  //bool _loaded = false; carregado...

  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async{
    final User? firebaseCurrentUser = firebaseUser ?? firebaseAuth.currentUser;
    if(firebaseCurrentUser != null){
      final DocumentSnapshot documentUser = await firestore.collection('users').doc(firebaseCurrentUser.uid).get();
      userModel = UserModel.fromDocument(documentUser);
      shoppingCartController.loadShoppingCart(userModel: userModel);
    }
    print("userModel.email após carregar: ${userModel?.email}");
    print("firebaseCurrentUser.email: ${firebaseCurrentUser?.email} ");
}

//loga
  Future<void> signIn({required UserModel userModel, required Function onFail, required Function onSuccess}) async{
    loading = true;
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: userModel.email!, password: userModel.password!);
      await _loadCurrentUser();
      onSuccess();
    }on FirebaseAuthException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }
  //cria conta
  Future<void> signUp({required UserModel userModel, required Function onFail, required Function onSuccess}) async{
    loading = true;
    try{
      final UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!);
      userModel.id = result.user!.uid;
      await userModel.saveDataUser();
      await _loadCurrentUser();
      onSuccess();
    }on FirebaseAuthException catch(e){
      await onFail(getErrorString(e.code));
    }
    loading = false; //carregando...
    //_loaded = true; //carregado.
  }

  Future<void> signOutUser({required UserModel? userModel})async{
    _loading = true;
    try{
      await firebaseAuth.signOut();
      userModel =  null;
      shoppingCartController.resetCart();
    }catch(e){
      print('UserController SignOutUser: deu ruim: $e');
    }
    _loading = false;
    notifyListeners();
  }
}