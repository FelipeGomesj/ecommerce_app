import 'package:ecommerce_app/controllers/shopping_cart_controller.dart';
import 'package:ecommerce_app/controllers/user_controller.dart';
import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:ecommerce_app/widgets/components/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configs/customColors.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';



class CartView extends StatefulWidget {
  const CartView({Key? key, this.onReturnAction}) : super(key: key);

  //VoidCallBack é exatamente como se estivesse passando o tipo Function, porém, aparentemente ele é usado para funções que não
  //retornam nenhum tipo de valor e também não recebem nenhum tipo de argumento/parâmetro, por isso o nome VoidCallback/chamada vazia de volta
  /*Em resumo, o VoidCallback é um tipo de função que representa uma ação sem argumentos nem valor de retorno,
   e é útil para definir ações que podem ser executadas em resposta a eventos ou ações do usuário.*/
  final VoidCallback? onReturnAction;
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context)  {
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
      //WillPopScope permite eu inserir comandos quando o usuário arrastar o dedo da direita para esquerda
      //com o recurso nativo do android para voltar as telas, ou seja, dar pop()
      body: WillPopScope(
        onWillPop:() async {
          if (widget.onReturnAction != null) {
            print("cart_view: widget.onReturnAction");
            widget.onReturnAction!();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: shoppingCartController.shoppingCartList.length, //productList.length,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //itemExtent: 200,
            itemBuilder: (context, index) {
              final cartItem = shoppingCartController.shoppingCartList[index];
              // Encontrando o produto correspondente na lista de produtos
              final product = productController.products.firstWhere(
                    (product) => product.id == cartItem.productId,
                orElse: () => ProductModel(images: null, name: null,  price: null, id: null, description: null, type: null),
              );
              return CartCard(
                shoppingCart: cartItem,
                product: product,
              );
            },
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton(onPressed: () async{
            print('PROCEED TO CHECKOUT');
            shoppingCartController.loadShoppingCart(userModel: userController.userModel);
          } , title: "PROCEED TO CHECKOUT"),
        ],
      ),
    ),
    );
  }
}
