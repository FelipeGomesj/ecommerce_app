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

  final List<ProductModel> productList = [];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Consumer<ProductController>(builder: (context, productController, child) => Scaffold(
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
        itemCount: 1, //productList.length,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        //itemExtent: 200,
        itemBuilder: (context, index) => CartCard(product: productController.products.first,//productList[index],
            amount: 1),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton(onPressed: () => print("ir para o pagamento..."), title: "PROCEED TO CHECKOUT"),
        ],
      ),
    ),
    );
  }
}
