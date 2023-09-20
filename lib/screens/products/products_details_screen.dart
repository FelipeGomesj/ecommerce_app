import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  num _count = 1;
  @override
  Widget build(BuildContext context) {
    //widget.productModel.description = widget.productModel.description!.replaceAll('\\n', "\n");
    //print(widget.productModel.description);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () => print('abrir carrinho...'),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 28,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Stack(
                alignment: Alignment.topRight,
               children: [
                 Card(
                   color: const Color.fromARGB(255, 217, 217, 217),
                   child: Image.network(widget.productModel.images!.first),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                     child: InkWell(
                         onTap: () => print('Favoritar produto: ${widget.productModel.name}'),
                         child: Icon(Icons.favorite))),
               ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    widget.productModel.name!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.orange.shade700),
                  ),
                ),
                // const Padding(
                //     padding: EdgeInsets.only(right: 16),
                //     child: Icon(Icons.favorite))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                //widget.productModel.description!,
                firebaseLineWrapping(widget.productModel.description!),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22, right: 8),
                    child: SizedBox(
                      width: 46,
                      child: ElevatedButton(
                        style: ButtonStyle(

                          shape: MaterialStateProperty.all(
                             RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _count -= 1;
                          setState(() {});
                        },
                        child: const Center(
                          child:  Text(
                            "-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 28),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$_count",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: 46,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                             RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _count += 1;
                          setState(() {});
                        },
                        child: const Text(
                          "+",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 26),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child:             Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.red, width: 2.5)),
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    )),
                onPressed: () {
                  print('adicionar para o carrinho');
                },
                child: const Text(
                  "Adicionar P/ carrinho",
                  style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                ),
                onPressed: () {
                  print('COMPRAR...');
                },
                child: const Text(
                  "COMPRAR",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
