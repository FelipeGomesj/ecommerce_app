import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/product_model.dart';
import '../../screens/auth_ui/pre_login_screen.dart';
import '../../screens/products/products_details_screen.dart';
import '../../tools/i18n_extension/product_grid_i18n.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    String formattedPrice =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2)
            .format(productModel.price);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProductsDetailsScreen(productModel: productModel),
        ),
      ),
      child: Card(
        //color: Colors.red.shade50,
        color: const Color.fromARGB(255, 246, 246, 246),
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Image.network(
                productModel.images!.first,
                //"https://frutasbrasilsul.com.br/wp-content/uploads/banana-nanica.png",
                width: 92,
                height: 92,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productModel.name!,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                //"R\$ ${price.toString().replaceAll(".", ",")}"
              ],
            ),
            Text(
              formattedPrice,
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            12.hg,
            InkWell(
              overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: "O que deseja fazer com ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              children: [
                                TextSpan(
                                    text: "${productModel.name} ?",
                                    style: const TextStyle(
                                        color: Colors.orange, fontSize: 18))
                              ]),
                        ),
                        16.hg,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                print('Adicionado no carrinho');
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Adicionar p/\ncarrinho.',
                                style: TextStyle(color: Colors.red,fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                print('Navegar até o pagamento');
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Ir para o \npagamento',
                                style: TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              child: Container(
                color: Colors.red,
                width: 100,
                height: 30,
                // decoration: BoxDecoration(
                //     border: Border.all(
                //       width: 1.5,
                //       //color: Colors.red,
                //     )
                // ),

                child: Center(
                  child: Text(
                    "COMPRAR".i18n,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
