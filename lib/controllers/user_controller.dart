import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_helper/firebase_errors.dart';
import '../models/user_model.dart';

class UserController extends ChangeNotifier {

  UserController(){
    _loadCurrentUser();
  }

  UserModel? userModel = UserModel();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool _loaded = false;

  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async{
    final User? firebaseCurrentUser = firebaseUser ?? firebaseAuth.currentUser;
    // print("firebaseCurrentUser?.uid: ${firebaseCurrentUser?.uid}");
    // print("firebaseCurrentUser?.email: ${firebaseCurrentUser?.email}");
    // print("userModel.email: ${userModel.email}");
    // if(userModel.email !=  firebaseCurrentUser?.email){
    //   firebaseCurrentUser?.reload();
    //   return;
    // }
    if(firebaseCurrentUser != null){
      final DocumentSnapshot documentUser = await firestore.collection('users').doc(firebaseCurrentUser.uid).get();
      userModel = UserModel.fromDocument(documentUser);
    }
    print("userModel.email após carregar: ${userModel?.email}");
    print("firebaseCurrentUser.email: ${firebaseCurrentUser?.email} ");
}

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
    _loaded = true;
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
    loading = false; //carregando...
    _loaded = true; //carregado.
  }

  Future<void> signOutUser({required UserModel? userModel})async{
    _loading = true;
    try{
      await firebaseAuth.signOut();
      userModel =  null;
    }catch(e){
      print('UserController SignOutUser: deu ruim: $e');
    }
    _loading = false;
    notifyListeners();
  }
}