import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_controller.dart';

class MainButton extends StatelessWidget {
  const MainButton({required this.onPressed, required this.title, this.color = Colors.red, super.key});

  final Function onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Consumer<UserController>( builder: (_, userController, __) =>
          SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: () => userController.loading == false ?  onPressed() : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => color),
            ),
            child: userController.loading == false ?  Text(
              title,
              style: const TextStyle(color: Colors.white),
            ) : const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
