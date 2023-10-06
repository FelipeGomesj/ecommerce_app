import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/components/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../configs/theme_config.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
      child: Form(
        key: _formKey,
        child: Consumer<UserController>( builder: (_, userController, __) => Scaffold(
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
                      focusNode: _focusNode[0], controller: _nameController,

                  ),
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
                 MainButton(onPressed: () async {
                    // bool isValidate = signUpValidation(email: _emailController.text, password: _passwordController.text, name: _nameController.text, phoneNumber: _phoneNumberController.text);
                    // if(isValidate){
                    //   bool isLogined = await FirebaseAuthHelper.instance.signUp(email: _emailController.text, password: _passwordController.text, context: context);
                    //   if(isLogined){
                    //     print('Navegar para home');
                    //   }
                    // }
                   //TODO já está logando e signup funcionando, agora criar a função para signout e fazer a lógica na home para botão de deslogar ou de fazer login
                   print(userController.userModel.name);
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      await userController.signUp(userModel: UserModel(
                        name: _nameController.text,
                        cellPhone: _phoneNumberController.text,
                        email: _emailController.text,
                        password: _passwordController.text
                      ), onFail:  (error)  => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Falha ao tentar: $error", style: const TextStyle(
                            fontSize: 18
                          ),),
                          backgroundColor: Colors.red,
                        ),
                      ) ,
                         onSuccess: () => Navigator.of(context).popAndPushNamed('/home'));
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
        ),
      ),
    );
  }
}
