import 'package:ecommerce_app/controllers/shopping_cart_controller.dart';
import 'package:ecommerce_app/controllers/user_controller.dart';
import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/components/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configs/customColors.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ValueNotifier<int> _countNotifier = ValueNotifier<int>(1);


  @override
  Widget build(BuildContext context) {
    //double _height = MediaQuery.of(context).size.height;
    return Consumer3<ProductController, ShoppingCartController, UserController>(builder: (BuildContext context, productController, shoppingCartController, userController, Widget?  child) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: CustomColors.appBarColorWithElevationAt_6,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Carrinho",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          )
        ],
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        elevation: 6,
      ),
      body: ListView.builder(
        itemCount: shoppingCartController.shoppingCartList.length, //productList.length,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        //itemExtent: 200,
          itemBuilder: (context, index) {
            final cartItem = shoppingCartController.shoppingCartList[index];
            // Encontre o produto correspondente na lista de produtos
            final product = productController.products.firstWhere(
                  (product) => product.id == cartItem.productId,
              orElse: () => ProductModel(images: null, name: null,  price: null, id: null, description: null, type: null), // Você pode definir um valor padrão aqui, caso o produto não seja encontrado
            );
            return CartCard(
              shoppingCart: cartItem,
              product: product,
            );
          },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton(onPressed: () async{
            print('teste');
            shoppingCartController.loadShoppingCart(userModel: userController.userModel);
          } , title: "PROCEED TO CHECKOUT"),
        ],
      ),
    ),
    );
  }
}
