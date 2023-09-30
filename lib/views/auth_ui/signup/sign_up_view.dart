import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/components/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../configs/theme_config.dart';
import '../../../constants/constants.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../tools/i18n_extension/signup_screen_i18n.dart';
import '../../../widgets/components/custom_text_field.dart';

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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  focusNode: _focusNode[0], controller: _nameController),
              16.hg,
              CustomTextField(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: "E-mail",
                  focusNode: _focusNode[1],
                  emailField: true, controller: _emailController),
              16.hg,
              CustomTextField(
                  prefixIcon: const Icon(Icons.phone_outlined),
                  hintText: "Número (com DDD)".i18n,
                  focusNode: _focusNode[2],
                  numberField: true, controller: _phoneNumberController),
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
                  passwordField: true, controller: _passwordController,),
              16.hg,
              MainButton(onPressed: () async{
                bool isValidate = signUpValidation(email: _emailController.text, password: _passwordController.text, name: _nameController.text, phoneNumber: _phoneNumberController.text);
                if(isValidate){
                  bool isLogined = await FirebaseAuthHelper.instance.signUp(email: _emailController.text, password: _passwordController.text, context: context);
                  if(isLogined){
                    print('Navegar para home');
                  }
                }

              }, title: "Criar Conta".i18n),
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
