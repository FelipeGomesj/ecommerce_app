import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid ({super.key, required this.title, required this.urlImage, required this.price });

  final String urlImage;
  final String title;
  final num price;

  @override
  Widget build(BuildContext context) {
    String formattedPrice = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2).format(price);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        padding: const EdgeInsets.only(
            bottom: 60, left: 8, right: 8, top: 4),
        children: [
          Card(
            child: Column(
              children: [
                Image.network(
                    urlImage,
                    //"https://frutasbrasilsul.com.br/wp-content/uploads/banana-nanica.png",
                    width: 120),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                     //"R\$ ${price.toString().replaceAll(".", ",")}"
                     Text(formattedPrice, style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                    ),

                  ],
                ),
                6.hg,
                InkWell(
                  overlayColor: MaterialStateColor.resolveWith((states) => Colors.red.shade100),
                  onTap: (){
                    print('COMPRAR...');
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.red,
                        )
                    ),
                    child: const Center(
                      child: Text(
                        "COMPRAR", style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
