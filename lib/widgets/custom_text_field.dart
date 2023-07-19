import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../configs/theme_config.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required  this.focusNode, required this.prefixIcon, required this.hintText, this.passwordField = false, this.numberField = false, this.emailField = false});
  final FocusNode focusNode;
  final Icon prefixIcon;
  final String hintText;
  final bool passwordField;
  final bool numberField;
  final bool emailField;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return widget.passwordField == true ? ValueListenableBuilder(
        valueListenable: _showPassword,
        builder: (BuildContext context, bool value, Widget? child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            focusNode: widget.focusNode,
            obscureText: _showPassword.value,
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
      child: TextField(
        focusNode: widget.focusNode,
        keyboardType: TextInputType.phone,
        maxLength: 11,
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
      child: TextField(
        focusNode: widget.focusNode,
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
    ) : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        focusNode: widget.focusNode,
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
