import 'package:ecommerce_app/screens/auth_ui/login/login_screen.dart';
import 'package:ecommerce_app/screens/auth_ui/signup/sign_up_screen.dart';
import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:ecommerce_app/screens/pre_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:provider/provider.dart';
import 'configs/theme_config.dart';
import 'managers/category_images_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(
        create: (_) => CategoryImagesManager(),
        lazy: false,
      )],
      child: I18n(
        //initialLocale: const Locale("pt", "BR"),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Config.themeData,
          home:  const HomeScreen(),
          onGenerateRoute: (settings){
            switch(settings.name){
              case '/pre_login':
                return MaterialPageRoute(builder:(_) =>  const PreLoginScreen());
              case '/login':
                return MaterialPageRoute(builder:(_) =>  const LoginScreen());
              case '/signup':
                return MaterialPageRoute(builder: (_) => const SignupScreen());
              case '/home':
                return MaterialPageRoute(builder:(_) =>  const HomeScreen());
              default:
                return MaterialPageRoute(builder:(_) =>  const HomeScreen());
            }
          },
        ),
      ),
    );
  }
}
