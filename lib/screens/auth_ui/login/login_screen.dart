import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';

import '../../../tools/custom_sized_box.dart';
import '../../../tools/i18n_extension/login_screen_i18n.dart';
import 'package:ecommerce_app/widgets/top_titles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final List<FocusNode> _focusNode = [FocusNode(), FocusNode()];
  @override
  void initState() {
    for (FocusNode node in _focusNode) {
      node.addListener(() {
        if (mounted) setState(() {});
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode[0].dispose();
    _focusNode[1].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(title: 'Login', subtitle: 'Bem-vindo de volta.'.i18n, arrowBack: true),
              32.hg,
              CustomTextField(focusNode: _focusNode[0], prefixIcon: const Icon(Icons.email_outlined), hintText: 'E-mail'),
              16.hg,
              CustomTextField(focusNode: _focusNode[1], prefixIcon: const Icon(Icons.password_outlined), hintText: 'Senha'.i18n, passwordField: true),
              16.hg,
              MainButton(onPressed: () {}, title: "Login"),
              16.hg,
              Center(
                child: Column(
                  children: [
                     Text('Não tem uma conta?'.i18n,
                      style: const TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w500
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.of(context).pushNamed('/signup'),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Crie uma conta'.i18n,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  //decoration: TextDecoration.underline
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
