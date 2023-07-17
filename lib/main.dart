import 'package:ecommerce_app/screens/auth_ui/login/login_screen.dart';
import 'package:ecommerce_app/screens/auth_ui/pre_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'configs/theme_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: const Locale("pt", "BR"),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: themeData,
        home:  const PreLoginScreen(),
        onGenerateRoute: (settings){
          switch(settings.name){
            case 'pre_login':
              return MaterialPageRoute(builder:(_) =>  const PreLoginScreen());
            case 'login':
              return MaterialPageRoute(builder:(_) =>  const LoginScreen());
            default:
              return MaterialPageRoute(builder:(_) =>  const PreLoginScreen());
          }
        },
      ),
    );
  }
}
