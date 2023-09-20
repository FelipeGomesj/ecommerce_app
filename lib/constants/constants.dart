import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:ecommerce_app/tools/i18n_extension/constants_i18n.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message){
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16
  );
}

String firebaseLineWrapping(String string){
  string = string.replaceAll('\\n', "\n");
  String formatedString = string;
  return formatedString;
}
final FirebaseFirestore firestore = FirebaseFirestore.instance;
showLoaderDialog(BuildContext context){
  AlertDialog alertDialog = AlertDialog(
    content: Builder(builder:(context){
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.orange,
            ),
           18.hg,
            Container(
              margin: const EdgeInsets.only(left: 7),
              child:  Text("Carregando...".i18n),
            )
          ],
        ),
      );
    })
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context){
      return alertDialog;
    }
  );
}

String getMessageFromErrorCode(String errorCode){
  switch(errorCode){
    case 'ERROR_WEAK_PASSWORD':
    case 'weak-password':
      return 'Sua senha é muito fraca.'.i18n;

    case 'ERROR_INVALID_EMAIL':
    case 'invalid-email':
      return 'Seu e-mail é inválido.'.i18n;

    case 'email-already-in-use':
    case 'account-exists-with-different-credential':
      return 'E-mail já está sendo utilizado em outra conta.'.i18n;

    case 'ERROR_INVALID_CREDENTIAL':
    case 'invalid-credential':
      return 'Seu e-mail é inválido.'.i18n;

    case 'ERROR_WRONG_PASSWORD':
    case 'wrong-password':
      return 'Sua senha está incorreta.'.i18n;

    case 'ERROR_USER_NOT_FOUND':
    case 'user-not-found':
      return 'Não há usuário com este e-mail.'.i18n;

    case 'ERROR_USER_DISABLED':
    case 'user-disabled':
      return 'Este usuário foi desabilitado.';

    case 'ERROR_TOO_MANY_REQUESTS':
    case 'operation-not-allowed':
      return 'Muitas solicitações. Tente novamente mais tarde.'.i18n;

    case 'ERROR_OPERATION_NOT_ALLOWED':
    case 'operation-not-allowed':
      return 'Operação não permitida.'.i18n;

    default:
      return 'Um erro indefinido ocorreu: '.i18n + errorCode;
  }
}

bool loginValidation({required String email, required String password}){
  if(email.isEmpty && password.isEmpty){
    showMessage("Todos os campos estão vazios".i18n);
    return false;
  }
  else if(email.isEmpty){
    showMessage("O E-mail está vazio".i18n);
    return false;
  }
  else if(password.isEmpty){
    showMessage("A senha está vazia".i18n);
    return false;
  }
  else{
    return true;
  }

}
bool signUpValidation({required String email, required String password, required String name, required, required String phoneNumber}){
  if(email.isEmpty && password.isEmpty && name.isEmpty && phoneNumber.isEmpty){
    showMessage("Todos os campos estão vazios".i18n);
    return false;
  }
  else if(email.isEmpty){
    showMessage("O E-mail está vazio".i18n);
    return false;
  }
  else if(password.isEmpty){
    showMessage("A senha está vazia".i18n);
    return false;
  }else if(name.isEmpty){
    showMessage('O nome está vazio'.i18n);
    return false;
}else if(phoneNumber.isEmpty){
    showMessage('O número de celular ou telefone está vazio'.i18n);
    return false;
}else{
    return true;
  }

}


