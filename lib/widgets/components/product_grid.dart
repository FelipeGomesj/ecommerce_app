import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configs/my_app_navigator_key.dart';
import '../../constants/constants.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/product_model.dart';
import '../../views/products/products_details_view.dart';
import '../../tools/i18n_extension/product_grid_i18n.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    //String formattedPrice = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2).format(productModel.price);
    return Consumer2<ShoppingCartController, UserController>(
      builder: (BuildContext context, shoppingCartController,userController, Widget? child) => GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            try {
              return ProductsDetailsScreen(
                productModel: productModel,
                shoppingCart: shoppingCartController.shoppingCartList
                    .firstWhere((item) => item.productId == productModel.id),
              );
            } catch (e) {
              return ProductsDetailsScreen(productModel: productModel);
            }
          }),
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
                ],
              ),
              Text(
                formatPrice(productModel.price!),
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              12.hg,
              InkWell(
                overlayColor: MaterialStateColor.resolveWith((states) => Colors.white),
                onTap: () => userController.userModel != null ? showDialog<String>(
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
                                text: "O que deseja fazer com ".i18n,
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
                                  shoppingCartController.addProductToCart(
                                      product: productModel, amount: 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "${productModel.name} adicionado no seu ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Carrinho",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline,
                                                decorationColor: Colors.white,
                                              ),
                                              recognizer: TapGestureRecognizer()..onTap = () => MyAppNavigatorKey.globalKey.currentState?.pushNamed('/cart'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Adicionar p/\ncarrinho'.i18n,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  print('Navegar até o pagamento');
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Ir para o \npagamento'.i18n,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ) : Navigator.of(context).pushNamed('/pre_login'),
                child: Container(
                  color: Colors.red,
                  width: 100,
                  height: 30,
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
      ),
    );
  }
}
