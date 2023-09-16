import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards(this.imageUrl, {super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.network(
          imageUrl,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 80,
            );
          },
        ),
      ),
    );

  }
}
