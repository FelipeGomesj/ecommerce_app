import 'package:ecommerce_app/tools/i18n_extension/pre_login_i18n.dart';
import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../tools/custom_sized_box.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopTitles(title: "BEM-VINDO", subtitle: "Compre o que você precisar do conforto de sua casa."),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Image.asset('assets/images/pre_login.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                  onPressed: () {
                    print('Facebook');
                  },
                  child: const Icon(Icons.facebook, size: 42, color: Colors.blue)),
              16.wd,
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    print('google');
                  },
                  child: Image.asset('assets/images/google-icon.png', height: 36,))
            ],
          ),
          18.hg,
          MainButton(onPressed: () => Navigator.of(context).pushNamed('login'), title: 'Login'),
          MainButton(onPressed: (){}, title: 'Cadastrar-se'.i18n)
        ],
      ),
    );
  }
}
