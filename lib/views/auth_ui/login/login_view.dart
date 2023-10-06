import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/components/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../configs/theme_config.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';
import '../../../tools/custom_sized_box.dart';
import '../../../tools/i18n_extension/login_screen_i18n.dart';
import 'package:ecommerce_app/widgets/components/top_titles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<FocusNode> _focusNode = [FocusNode(), FocusNode()];
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
      child: Form(
        key: _formKey,
        child: Consumer<UserController>(
          builder: (_, userController, __) => Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopTitles(
                      title: 'Login',
                      subtitle: 'Bem-vindo de volta.'.i18n,
                      arrowBack: false),
                  32.hg,
                  CustomTextField(
                      focusNode: _focusNode[0],
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: 'E-mail',
                      controller: _email),
                  16.hg,
                  CustomTextField(
                    focusNode: _focusNode[1],
                    prefixIcon: Icon(Icons.password_outlined,
                        color: _focusNode[1].hasFocus
                            ? Config.themeData.primaryColor
                            : Config.themeData.disabledColor),
                    hintText: 'Senha'.i18n,
                    passwordField: true,
                    controller: _password,
                  ),
                  16.hg,
                       MainButton(
                          onPressed: () async {
                            // bool isValidate = loginValidation(email: _email.text, password: _password.text);
                            // if(isValidate){
                            //  bool isLogined = await FirebaseAuthHelper.instance.login(email: _email.text, password: _password.text, context: context);
                            //  if(isLogined){
                            //    Navigator.of(context).popAndPushNamed('/home');
                            //  }
                            // }
                            if (_formKey.currentState!.validate()) {
                              userController.signIn(
                                  userModel: UserModel(
                                      email: _email.text,
                                      password: _password.text),
                                  onFail: (error) {
                                    if(_email.text.isEmpty || _password.text.isEmpty){
                                      return ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Falha ao tentar: e-mail ou senha está vazio.",
                                            style:
                                             TextStyle(fontSize: 18),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                    bool isValidate = loginValidation(email: _email.text, password: _password.text);
                                    if(!isValidate){
                                      return ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Falha ao tentar: $error",
                                            style:
                                            const TextStyle(fontSize: 18),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Falha ao tentar: $error",
                                          style:
                                          const TextStyle(fontSize: 18),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  onSuccess: () => Navigator.of(context)
                                      .popAndPushNamed('/home'));
                            }
                          },
                          title: "Login"),
                  16.hg,
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Não tem uma conta?'.i18n,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/signup'),
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
        ),
      ),
    );
  }
}
