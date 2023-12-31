import 'package:ecommerce_app/controllers/shopping_cart_controller.dart';
import 'package:ecommerce_app/views/auth_ui/login/login_view.dart';
import 'package:ecommerce_app/views/auth_ui/signup/sign_up_view.dart';
import 'package:ecommerce_app/views/home/home_view.dart';
import 'package:ecommerce_app/views/auth_ui/pre_login_view.dart';
import 'package:ecommerce_app/views/shopping_cart/cart_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:provider/provider.dart';
import 'configs/my_app_navigator_key.dart';
import 'configs/theme_config.dart';
import 'controllers/category_images_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/user_controller.dart';

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
      ),
        ChangeNotifierProvider(
          create: (_) => ProductController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UserController(),
          lazy:false
        ),
        ChangeNotifierProvider(create: (_) => ShoppingCartController(),
        )
      ],
      child: I18n(
        //initialLocale: const Locale("pt", "BR"),
        child: MaterialApp(
          navigatorKey: MyAppNavigatorKey.globalKey,
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
              case '/cart':
                return MaterialPageRoute(builder:(_) => const CartView());
              default:
                return MaterialPageRoute(builder:(_) =>  const HomeScreen());
            }
          },
        ),
      ),
    );
  }
}
