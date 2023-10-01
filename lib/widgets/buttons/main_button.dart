import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({required this.onPressed, required this.title, this.color = Colors.red, super.key});

  final Function onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => color),
          ),
        ),
      ),
    );
  }
}
