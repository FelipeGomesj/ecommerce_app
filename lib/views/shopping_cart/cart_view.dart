import 'package:ecommerce_app/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';

import '../../configs/customColors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ValueNotifier<int> _countNotifier = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
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
        itemCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        //itemExtent: 200,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red, width: 2.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: CustomColors.backgroundColorImage,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Image.asset("assets/images/sad-fast-food.jpg")),
                  // Outros widgets dentro do Card
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 140,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, left: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            ValueListenableBuilder<int>(
                              valueListenable: _countNotifier,
                              builder: (context, sum, child) => Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 8),
                                    child: SizedBox(
                                      width: 38,
                                      height: 30,
                                      child: _countNotifier.value > 1
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                if (_countNotifier.value <= 1) {
                                                  _countNotifier.value += 1;
                                                }
                                                _countNotifier.value -= 1;
                                                //print(_countNotifier.value);
                                              },
                                              onLongPress: () {
                                                while (
                                                    _countNotifier.value > 1) {
                                                  _countNotifier.value -= 1;
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 1),
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            )
                                          : ElevatedButton(
                                              style: ButtonStyle(
                                                  shadowColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Colors.transparent),
                                                  overlayColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Colors.transparent),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                                  .red
                                                                  .withAlpha(
                                                                      180))),
                                              onPressed: () => (null),
                                              child: Center(
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                          .withAlpha(80),
                                                      fontSize: 18),
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
                                        onPressed: () =>
                                            _countNotifier.value += 1,
                                        child: const Text(
                                          "+",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => print('adicionar produto para o favorito'),
                              child: Text(
                              "Add to favorite",
                                style: TextStyle(
                                  color: Colors.red
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text('R\$ 000,00', style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton(onPressed: () => print("ir para o pagamento..."), title: "PROCEED TO CHECKOUT"),
        ],
      ),
    );
  }
}
