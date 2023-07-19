import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../configs/theme_config.dart';
import '../../../tools/i18n_extension/signup_screen_i18n.dart';
import '../../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final List<FocusNode> _focusNode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                  title: 'Criar uma Conta'.i18n,
                  subtitle: 'Bem-vindo à Loja'.i18n,
                  arrowBack: true),
              8.hg,
              CustomTextField(
                  prefixIcon: const Icon(Icons.person_outline),
                  hintText: "Nome".i18n,
                  focusNode: _focusNode[0]),
              16.hg,
              CustomTextField(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: "E-mail",
                  focusNode: _focusNode[1],
                  emailField: true),
              16.hg,
              CustomTextField(
                  prefixIcon: const Icon(Icons.phone_outlined),
                  hintText: "Número (com DDD)".i18n,
                  focusNode: _focusNode[2],
                  numberField: true),
              16.hg,
              CustomTextField(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: _focusNode[3].hasFocus
                        ? Config.themeData.primaryColor
                        : Config.themeData.disabledColor,
                  ),
                  hintText: "Senha".i18n,
                  focusNode: _focusNode[3],
                  passwordField: true),
              16.hg,
              MainButton(onPressed: () {}, title: "Criar Conta".i18n),
              16.hg,
              Center(
                child: Column(
                  children: [
                     Text(
                      'Já possui uma conta?'.i18n,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    4.hg,
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.of(context).pushNamed('/login'),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Config.themeData.primaryColor, fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
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
