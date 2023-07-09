import 'package:ecommerce_app/tools/i18n_extension/pre_login_i18n.dart';
import 'package:ecommerce_app/tools/screen_size.dart';
import 'package:flutter/material.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = ScreenSize.width;
    double _height = ScreenSize.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            //vertical: _width * 0.12 , horizontal: 16
            padding: EdgeInsets.only(top: _width * 0.12, left: 16),
            child:  Text(
              'BEM-VINDO'.i18n,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 16),
            child:  Text('Compre o que você precisar do conforto de sua casa.'.i18n, style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic
            ),
            ),
          ),
        ],
      ),
    );
  }
}
