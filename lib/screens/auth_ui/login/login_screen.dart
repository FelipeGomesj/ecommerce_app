import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:flutter/cupertino.dart';

import '../../../tools/custom_sized_box.dart';
import 'package:ecommerce_app/widgets/top_titles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final List<FocusNode> _focusNode = [FocusNode(), FocusNode()];
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(true);
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(
                title: 'Login', subtitle: 'Bem-vindo de volta.', arrowBack: true),
            32.hg,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                focusNode: _focusNode[0],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _focusNode[0].hasFocus
                      ? Colors.white
                      : Colors.blueGrey.withAlpha(6),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color:
                        _focusNode[0].hasFocus ? Colors.redAccent : Colors.grey,
                  ),
                  hintText: 'E-mail',
                  hintStyle: TextStyle(
                      color:
                          _focusNode[0].hasFocus ? Colors.redAccent : Colors.grey,
                      fontWeight: _focusNode[0].hasFocus
                          ? FontWeight.normal
                          : FontWeight.w500),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: ValueListenableBuilder(
                valueListenable: _showPassword,
                builder: (BuildContext context, bool value, Widget? child) =>
                    TextField(
                  focusNode: _focusNode[1],
                  obscureText: _showPassword.value,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _focusNode[1].hasFocus
                        ? Colors.white
                        : Colors.blueGrey.withAlpha(6),
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: _focusNode[1].hasFocus ? Colors.red : Colors.grey,
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        color: _focusNode[1].hasFocus
                            ? Colors.redAccent
                            : Colors.grey,
                        fontWeight: _focusNode[1].hasFocus
                            ? FontWeight.normal
                            : FontWeight.w500),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _showPassword.value = !_showPassword.value;
                      },
                      child: _showPassword.value == true
                          ? Icon(
                              Icons.visibility,
                              color: _focusNode[1].hasFocus
                                  ? Colors.red
                                  : Colors.grey,
                            )
                          : Icon(Icons.visibility_off,
                              color: _focusNode[1].hasFocus
                                  ? Colors.red
                                  : Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      )
                    )
                  ),
                ),
              ),
            ),
            MainButton(onPressed: () {}, title: "Login"),
            16.hg,
            Center(
              child: Column(
                children: [
                  const Text(
                    'Não tem uma conta? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      print('Navegar para criação de conta');
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Crie uma conta',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
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
    );
  }
}
