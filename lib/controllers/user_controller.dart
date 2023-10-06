import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_helper/firebase_errors.dart';
import '../models/user_model.dart';

class UserController extends ChangeNotifier {

  UserController(){
    _loadCurrentUser();
  }

  UserModel userModel = UserModel();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool _userLoaded = false;

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
    }
}

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
    loading = false; //carregando
    _userLoaded = true; //carregado
  }
}