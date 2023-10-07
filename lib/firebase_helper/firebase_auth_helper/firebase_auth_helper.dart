import 'package:ecommerce_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login({required String email, required String password, required BuildContext context}) async {
    try{
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException  catch(error){
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
  Future<bool> signUp({required String email, required String password, required BuildContext context}) async {
    try{
      showLoaderDialog(context);
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      print('Navegar para home');
      return true;
    } on FirebaseAuthException  catch(error){
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> isLogined({required UserModel userModel, required BuildContext context}) async{
    bool userIsLogged = await FirebaseAuthHelper.instance.signUp(email: userModel.email!, password: userModel.password!, context: context);
    return userIsLogged;
  }

}