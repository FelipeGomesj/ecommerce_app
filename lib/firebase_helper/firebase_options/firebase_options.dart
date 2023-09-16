import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
class DefaultFirebaseConfig {
  static FirebaseOptions get plaformOptions{
    //iOS and MacOS:
    if(Platform.isIOS){
      return const FirebaseOptions(
        appId: '1:653158061102:ios:dabe1dd059a7fd3e327bbf', //Banco de dados do  Firebase > config(Engrenagem do lado de "Visão geral do projeto") > Geral,  "Seus Aplicativos" ID do aplicativo obs: Os id's de ios e android são diferentes, pegar separadamente do ios e do android
        apiKey: 'AIzaSyC9ilUcF9Fk1Zzi1QEeXkn84alAbs1jqVU', //linha 10 do arquivo GoogleService-Info.plist Dentro da pasta ios > Runner
        projectId: 'e-commerce-app-34c63', //linha 18 do arquivo GoogleService-Info.plist Dentro da pasta ios > Runner
        messagingSenderId:'653158061102', //Banco de dados do  Firebase > config(Engrenagem do lado de "Visão geral do projeto") > Cloud Messaging > ID do remetente
        iosBundleId: 'com.example.ecommerceApp' ////linha 16 do arquivo GoogleService-Info.plist Dentro da pasta ios > Runner
      );
      //Android:
    }else{
      return const FirebaseOptions(
        appId:'1:653158061102:android:0608dac20f16487d327bbf', //Banco de dados do  Firebase > config(Engrenagem do lado de "Visão geral do projeto") > Geral,  "Seus Aplicativos" ID do aplicativo obs: Os id's de ios e android são diferentes, pegar separadamente do ios e do android
        apiKey:'AIzaSyC-plXAcTNk4xA1loAdwHG9A1A3ci41Qmw' ,//android > app > google-services.json: linha 23 "api_key", current_key
        projectId: 'e-commerce-app-34c63',
        messagingSenderId: '653158061102',
      );
    }
  }
}