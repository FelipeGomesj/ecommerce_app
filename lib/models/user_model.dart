import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  UserModel({
    this.name,
    this.id,
    this.cellPhone,
    this.password,
    this.email
});

  String? id;
  String? name;
  String? email;
  String? password;
  String? cellPhone;


   UserModel.fromDocument(DocumentSnapshot doc){
     id = doc.id;
     name = doc['name'] ?? '';
     email = doc['email'] ?? '';
     cellPhone = doc['cellPhone'] ?? '';
  }

  DocumentReference get firestoreUserRef => FirebaseFirestore.instance.doc('users/$id');
  Future<void> saveDataUser() async {
     await firestoreUserRef.set(toMapUserModel());
  }
  Map<String,dynamic> toMapUserModel() {
    return {
      'name': name,
      'email': email,
      'cellPhone': cellPhone
    };
  }
}