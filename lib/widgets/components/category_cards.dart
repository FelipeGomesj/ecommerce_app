import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards(this.imageUrl, this.touch, {super.key});
  final String imageUrl;
  final Function touch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => touch(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.white,
        elevation: 4,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
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
      ),
    );

  }
}
