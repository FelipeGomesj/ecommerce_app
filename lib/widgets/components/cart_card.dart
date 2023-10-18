import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/products/products_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/customColors.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../models/shopping_cart_model.dart';

class CartCard extends StatefulWidget {
  const CartCard({Key? key, required this.shoppingCart, required this.product})
      : super(key: key);
  final ShoppingCartModel shoppingCart;
  final ProductModel product;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final ValueNotifier<int> _countNotifier = ValueNotifier<int>(0);
  final ValueNotifier<num> _productPriceSum = ValueNotifier<num>(0);


  @override
  Widget build(BuildContext context) {
    _countNotifier.value = widget.shoppingCart.amount!;
    _productPriceSum.value = widget.shoppingCart.unitProductPrice!;
    return Consumer<ShoppingCartController>(
      builder: (_, shoppingCartController, __) => Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red, width: 2.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) {
                        try{
                          return ProductsDetailsScreen(
                            productModel: widget.product,
                            shoppingCart: shoppingCartController.shoppingCartList.firstWhere((item) => item.productId == widget.product.id),
                          );

                        }catch(e){
                          return ProductsDetailsScreen(productModel: widget.product);
                        }
                      }
                  ),
                ),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: CustomColors.backgroundColorImage,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Image.network(widget.product.images!.first),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 140,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8, left: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: _countNotifier,
                            builder: (context, sum, child) => Row(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 8),
                                  child: SizedBox(
                                    width: 38,
                                    height: 30,
                                    child: _countNotifier.value > 1
                                        ? ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (_countNotifier.value <= 1) {
                                                _countNotifier.value += 1;
                                              }
                                              _countNotifier.value -= 1;
                                              _productPriceSum.value -=
                                                  widget.product.price!;
                                              shoppingCartController.removeProductToCart(productId: widget.product.id!);
                                              shoppingCartController.notifyListeners();
                                            },
                                            onLongPress: () {
                                              while (_countNotifier.value > 1) {
                                                _countNotifier.value -= 1;
                                                _productPriceSum.value -=
                                                    widget.product.price!;
                                                shoppingCartController
                                                    .removeProductToCart(
                                                        productId:
                                                            widget.product.id!);
                                                shoppingCartController
                                                    .notifyListeners();
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0, right: 1),
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          )
                                        //botão remover item
                                        : ElevatedButton(
                                            style: ButtonStyle(
                                              shadowColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      Colors.transparent),
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      Colors.transparent),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateColor
                                                      //Colors.red.withAlpha(180)
                                                      .resolveWith((states) =>
                                                          Colors.grey),
                                            ),
                                            onPressed: () => showDialog(
                                              context: context,
                                              builder: (context) => Center(
                                                child: Card(
                                                  color: Colors.white,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 24),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                              children: [
                                                                const TextSpan(
                                                                  text:
                                                                      "Remover ",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                TextSpan(
                                                                  text: widget
                                                                      .product
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: CustomColors
                                                                          .orangeTitle,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                const TextSpan(
                                                                  text:
                                                                      " do carrinho ? ",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ]),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 32),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await shoppingCartController.removeProductToCart(
                                                                      productId: widget
                                                                          .product
                                                                          .id!);
                                                                  print(
                                                                      'Removendo ${widget.product.name}');
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Remover",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .red,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    decorationColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child: Text(
                                                                  "Voltar para o carrinho",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 2),
                                              child: Text(
                                                "x",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    //color: Colors.white.withAlpha(80),
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                Text(
                                  "${_countNotifier.value}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: SizedBox(
                                    width: 39,
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        _countNotifier.value += 1;
                                        _productPriceSum.value =
                                            widget.product.price!;
                                        //print('_countNotifier.value: ${_countNotifier.value}');
                                        shoppingCartController.addProductToCart(product: widget.product, amount: _countNotifier.value);
                                        shoppingCartController.notifyListeners();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0),
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          widget.product.isFavorite == false
                              ? InkWell(
                                  onTap: () => print(
                                      'adicionar produto para o favorito'),
                                  child: const Text(
                                    "Add to favorite",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Text(
                        formatPrice(widget.shoppingCart.totalProductPrice),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
