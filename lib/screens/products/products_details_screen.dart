import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/constants.dart';
import '../../tools/i18n_extension/product_details_i18n.dart';
class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  //num _count = 1;
  final ValueNotifier<int> _countNotifier = ValueNotifier<int>(1);
  final CarouselController _carouselController = CarouselController();
  final ValueNotifier<int>  _carouselIndexNotifier  = ValueNotifier<int>(0);

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
                    child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.width,
                        autoPlay: false,
                        reverse: false,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) =>
                            _carouselIndexNotifier.value = index,
                      ),
                      itemCount: widget.productModel.images!.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) =>
                              Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: const EdgeInsets.all(8),
                        child: GestureDetector(
                          child: Image.network(
                            widget.productModel.images![index],
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: InkWell(
                      onTap: () => print(
                          'Favoritar produto: ${widget.productModel.name}'),
                      child: Icon(Icons.favorite),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.4,
                    right: MediaQuery.of(context).size.width / 2.5,
                    child: ValueListenableBuilder<int>(
                      valueListenable: _carouselIndexNotifier,
                      builder: (context, index, child) => widget.productModel.images!.length > 1 ?AnimatedSmoothIndicator(
                        activeIndex: _carouselIndexNotifier.value,
                        count: widget.productModel.images!.length,
                        onDotClicked: (index) => _carouselController.animateToPage(index),
                        effect: const WormEffect(
                            activeDotColor: Colors.red),
                      ) : Container(),
                    ),
                    //child: buildIndicator(),
                  ),
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _countNotifier,
              builder: (context, sum, child ) => Padding(
                padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
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
                            _countNotifier.value -= 1;
                            print( _countNotifier.value);
                          },
                          child: const Center(
                            child: Text(
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
                      "${_countNotifier.value}",
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
                          onPressed: () => _countNotifier.value += 1,
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
              ),
              child: Padding(
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
                            _countNotifier.value -= 1;
                            print( _countNotifier.value);
                          },
                          child: const Center(
                            child: Text(
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
                      "${_countNotifier.value}",
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
                          onPressed: () => _countNotifier.value += 1,
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
              ),
            ),
            Row(
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
                    child:  Text(
                      "Adicionar P/ carrinho".i18n,
                      style:
                      const TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 160,
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
                      child: Text(
                        "COMPRAR".i18n,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}