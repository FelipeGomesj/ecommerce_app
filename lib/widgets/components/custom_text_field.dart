import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../configs/theme_config.dart';
import '../../models/user_model.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.controller, required  this.focusNode, required this.prefixIcon, required this.hintText, this.passwordField = false, this.numberField = false, this.emailField = false});
  final FocusNode focusNode;
  final Icon prefixIcon;
  final String hintText;
  final bool passwordField;
  final bool numberField;
  final bool emailField;
  final TextEditingController controller;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(true);
  final UserModel _userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    return widget.passwordField == true ? ValueListenableBuilder(
        valueListenable: _showPassword,
        builder: (BuildContext context, bool value, Widget? child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: _showPassword.value,
            onSaved: (pass) => _userModel.password = pass,
            decoration: InputDecoration(
                filled: true,
                fillColor: widget.focusNode.hasFocus
                    ? Colors.white
                    : Config.themeData.inputDecorationTheme.fillColor,
                prefixIcon: widget.prefixIcon,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: widget.focusNode.hasFocus
                        ? Config.themeData.primaryColor
                        : Config.themeData.disabledColor,
                    fontWeight: widget.focusNode.hasFocus
                        ? FontWeight.normal
                        : FontWeight.w500),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showPassword.value = !_showPassword.value;
                  },
                  child: _showPassword.value == true
                      ? Icon(
                    Icons.visibility,
                    color: widget.focusNode.hasFocus
                        ? Config.themeData.primaryColor
                        : Config.themeData.disabledColor,
                  )
                      : Icon(Icons.visibility_off,
                      color: widget.focusNode.hasFocus
                          ? Config.themeData.primaryColor
                          : Config.themeData.disabledColor),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red
                    )
                )
            ),
          ),
        )
    ) : widget.numberField == true ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.phone,
        maxLength: 11,
        onSaved: (number) => _userModel.cellPhone = number,
        decoration: InputDecoration(
            filled: true,
            fillColor: widget.focusNode.hasFocus ? Colors.white : Config.themeData.inputDecorationTheme.fillColor,
            counterText: '',
            prefixIcon: widget.prefixIcon,
            prefixIconColor: widget.focusNode.hasFocus ? Config.themeData.primaryColor : Config.themeData.disabledColor,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: widget.focusNode.hasFocus ? Config.themeData.primaryColor : Config.themeData.disabledColor,
                fontWeight: widget.focusNode.hasFocus
                    ? FontWeight.normal
                    : FontWeight.w500),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.focusNode.hasFocus ? Colors.red : Colors.grey
                )
            )
        ),
      ),
    ) : widget.emailField ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: (email) {
          if(email!.isEmpty){
            print('email vazios');
          }
        },
        onSaved:(email) => _userModel.email = email,
        decoration: InputDecoration(
            filled: true,
            fillColor: widget.focusNode.hasFocus ? Colors.white : Config.themeData.inputDecorationTheme.fillColor,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: widget.focusNode.hasFocus ? Config.themeData.primaryColor : Config.themeData.disabledColor,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: widget.focusNode.hasFocus ? Config.themeData.primaryColor : Config.themeData.disabledColor,
                fontWeight: widget.focusNode.hasFocus
                    ? FontWeight.normal
                    : FontWeight.w500),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.focusNode.hasFocus ? Colors.red : Colors.grey
                )
            )
        ),
      ),
      //NameField
    ) : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onSaved:(name) => _userModel.name = name,
        decoration: InputDecoration(
            filled: true,
            fillColor: widget.focusNode.hasFocus ? Colors.white : Config.themeData.inputDecorationTheme.fillColor,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: widget.focusNode.hasFocus ? Config.themeData.primaryColor : Config.themeData.disabledColor,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: widget.focusNode.hasFocus ? Config.themeData.primaryColor : Config.themeData.disabledColor,
                fontWeight: widget.focusNode.hasFocus
                    ? FontWeight.normal
                    : FontWeight.w500),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.focusNode.hasFocus ? Colors.red : Colors.grey
                )
            )
        ),
      ),
    );
  }
}
