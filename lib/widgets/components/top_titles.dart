import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  final String title, subtitle;
  final bool? arrowBack;
  final bool? safeKToolbarHeight;
  const TopTitles({super.key, required this.title, required this.subtitle, this.arrowBack = false, this.safeKToolbarHeight = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SizedBox(
          height: safeKToolbarHeight == true ?  kToolbarHeight : 10, // kToolbarHeight Alinha a altura segura para qualquer celular, para ui não ficar por cima de câmera ou outra coisa que comprometa a mesma
        ),
       if(arrowBack == true)
         Padding(
           padding: const EdgeInsets.only(left: 10, bottom: 18),
           child: InkWell(
             onTap: () async {
                FocusScope.of(context).unfocus();
                await Future.delayed(const Duration(milliseconds: 100));
                Navigator.of(context).pop();
                //Navigator.pop;
             },
             child: const Icon(Icons.arrow_back, size: 26,),),
         ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ),
      ]
    );
  }
}
