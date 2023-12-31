import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/shopping_cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../configs/customColors.dart';
import '../../constants/constants.dart';
import '../../controllers/shopping_cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/shopping_cart_model.dart';
import '../../tools/i18n_extension/product_details_i18n.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen(
      {super.key, required this.productModel, this.shoppingCart});

  final ProductModel productModel;
  final ShoppingCartModel? shoppingCart;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen>
    with TickerProviderStateMixin {
  final ValueNotifier<int> _countNotifier = ValueNotifier<int>(1);
  final ValueNotifier<num> _productPriceSum = ValueNotifier<num>(0);
  final CarouselController _carouselController = CarouselController();
  final ValueNotifier<int> _carouselIndexNotifier = ValueNotifier<int>(0);
  final TransformationController _scaleController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  AnimationController? _controllerReset;

  @override
  void initState() {
    _controllerReset = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    if (widget.shoppingCart != null) {
      _productPriceSum.value = widget.shoppingCart!.totalProductPrice;
      _countNotifier.value = widget.shoppingCart!.amount!;
      print("Products_details_view: initState widget.shoppingCart");
    } else {
      print("Products_details_view: initState: shoppingCart == null");
      _productPriceSum.value = widget.productModel.price!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> _isFavorite = ValueNotifier<bool>(widget.productModel.isFavorite);
    return Consumer2<ShoppingCartController, UserController>(
      builder: (BuildContext context, shoppingCartController, userController, Widget? child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            userController.userModel != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CartView(
                      onReturnAction: () => callInitStateOnReturn(),
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 28,
                  color: Colors.black,
                ),
              ),
            ) : Container()
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Card(
                      color: CustomColors.backgroundColorImage,
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
                                Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: widget.productModel.images!.length > 1
                                  ? 40
                                  : 0),
                          child: GestureDetector(
                            onDoubleTap: _handleDoubletap,
                            onDoubleTapDown: _handleDoubleTapDown,
                            child: InteractiveViewer(
                              transformationController: _scaleController,
                              onInteractionEnd: (interectionEnd) =>
                                  _resetScale(),
                              child: ClipRect(
                                child: Image.network(
                                  widget.productModel.images![index],
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: _isFavorite,
                        builder: (_, __, ___) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: InkWell(
                                onTap: () {
                                  _isFavorite.value = !_isFavorite.value;
                                  widget.productModel.isFavorite = _isFavorite.value;
                                },
                                child: _isFavorite.value
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                              ),
                            )),
                    //Alinhamento dos indicadores de imagens, o positioned.fill considera o tamanho inteiro do widget pai,
                    //que neste caso é o Stack lá da linha 50.
                    Positioned.fill(
                      child: Container(
                        //color: Colors.blue,
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: ValueListenableBuilder<int>(
                            valueListenable: _carouselIndexNotifier,
                            builder: (context, index, child) => widget
                                        .productModel.images!.length >
                                    1
                                ? AnimatedSmoothIndicator(
                                    activeIndex: _carouselIndexNotifier.value,
                                    count: widget.productModel.images!.length,
                                    onDotClicked: (index) => _carouselController
                                        .animateToPage(index),
                                    effect: const WormEffect(
                                        activeDotColor: Colors.red),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
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
                          color: CustomColors.orangeTitle),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Text(
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
              ValueListenableBuilder<num>(
                  valueListenable: _productPriceSum,
                  builder: (context, sum, child) => ValueListenableBuilder<int>(
                        valueListenable: _countNotifier,
                        builder: (context, sum, child) => Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 16, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, right: 8),
                                child: SizedBox(
                                  width: 46,
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
                                                widget.productModel.price!;
                                          },
                                          onLongPress: () {
                                            while (_countNotifier.value > 1) {
                                              _countNotifier.value -= 1;
                                              _productPriceSum.value -=
                                                  widget.productModel.price!;
                                            }
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
                                        )
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
                                                      .resolveWith((states) =>
                                                          Colors.red
                                                              .withAlpha(180))),
                                          onPressed: () => (null),
                                          child: Center(
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                                      .withAlpha(80),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      _countNotifier.value += 1;
                                      //num _price = widget.productModel.price!;
                                      _productPriceSum.value +=
                                          widget.productModel.price!;
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
                              ),
                              const Spacer(),
                              Text(
                                //formatPrice(_productPriceSum.value),
                                formatPrice(widget.productModel.price! * _countNotifier.value),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      )),
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
                        ),
                      ),
                      onPressed: () {
                        shoppingCartController.addProductToCart(
                            product: widget.productModel,
                            amount: _countNotifier.value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "${widget.productModel.name} adicionado no seu ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Carrinho",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Adicionar P/ carrinho".i18n,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
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
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubletap() {
    if (_scaleController.value != Matrix4.identity()) {
      _scaleController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      _scaleController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy) //2
        ..scale(2.5); //3.0
    }
  }

  void _resetScale() {
    final animationReset =
        Matrix4Tween(begin: _scaleController.value, end: Matrix4.identity())
            .animate(_controllerReset!);

    animationReset.addListener(() {
      _scaleController.value = animationReset.value;
    });
    _controllerReset!.reset();
    _controllerReset!.forward();
  }

  //Essa função irá dar um pop na screen que irá chamar (neste caso na cart_view), e chamar o iniState desta própria screen
  void callInitStateOnReturn() {
    Navigator.pop(context);
    initState();
  }
}
