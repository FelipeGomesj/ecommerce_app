import 'package:ecommerce_app/controllers/category_images_controller.dart';
import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:ecommerce_app/tools/i18n_extension/home_screen_i18n.dart';
import 'package:ecommerce_app/widgets/components/category_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/components/product_grid.dart';
import '../../widgets/components/top_titles.dart';
import '../products/category_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<FocusNode> _focusNode = [FocusNode()];

  //A linha 12 "_focusNode[0].addListener(_onFocusChanged);", juntamente com a função "_onFocusChanged" corrige o bug do focus não funcionar
  //na primeira vez que é clicado na barra de pesquisa
  //comentar as duas linhas e reiniciar o app caso haja dúvida, sendo assim, entenderá o erro.
  @override
  void initState() {
    super.initState();
    _focusNode[0].addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    setState(() {}); // Atualize o widget quando o foco mudar
  }

  @override
  Widget build(BuildContext context) {
    final categoryImagesManager = Provider.of<CategoryImagesManager>(context);
    final categoryImagesList = categoryImagesManager.categoryImagesList;
    final _productManager = Provider.of<ProductController>(context);
    final _productList = _productManager.products;

    //final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    //print(_height);
    //print(_width);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<UserController>(
        builder: (_, userController, __) => Scaffold(
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopTitles(title: 'Storia Foods', subtitle: ''),
                userController.userModel?.id != null &&
                        userController.userModel?.id != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: "Bem-vindo, ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: "${userController.userModel!.name}.",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                      fontSize: 18),
                                )
                              ]),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              await userController.signOutUser(
                                  userModel: userController.userModel);
                              userController.userModel = null;
                            },
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).pushNamed('/pre_login'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Login",
                                  style: TextStyle(fontSize: 16),
                                ),
                                8.wd,
                                const Icon(
                                  Icons.login,
                                  color: Colors.green,
                                  size: 28,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                16.hg,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: _height * 0.09,
                    child: TextField(
                      focusNode: _focusNode[0],
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(Icons.search, size: 28),
                          fillColor: _focusNode[0].hasFocus
                              ? Colors.white
                              : const Color.fromRGBO(213, 213, 213, 0.5),
                          hintText: 'Pesquisar'.i18n,
                          hintStyle: const TextStyle(
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(213, 213, 213, 0.5),
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Text(
                    'Categorias'.i18n,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: _height * 0.15, //15% da altura tela.
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        itemCount: categoryImagesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final imageUrl =
                              categoryImagesList.map((e) => e.image).toList();
                          return CategoryCards(imageUrl[index]!, () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CategoryScreen(categoryImagesList[index]),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                TopTitles(
                    title: "Mais vendidos".i18n,
                    subtitle: '',
                    safeKToolbarHeight: false),
                /*Best Sellers*/
                //const ProductGrid(title: 'Banana Prata', urlImage: 'https://frutasbrasilsul.com.br/wp-content/uploads/banana-nanica.png', price: 2.5,)
                _productList.isEmpty
                    ? Center(
                        child: Text(
                          "Desculpe, ainda não há produtos aqui... :(".i18n,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : SizedBox(
                        //height: MediaQuery.of(context).size.height / 2,
                        height: _height,
                        //height: 100,
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              bottom: _height <= 800
                                  ? _height * 0.75
                                  : _height * 0.6,
                              left: 8,
                              right: 8,
                              top: 0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: _height >= 800 ? 0.8 : 0.75,
                            //mainAxisExtent: _height * 0.3
                            //childAspectRatio: 0.8
                          ),
                          itemCount: _productList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              ProductGrid(productModel: _productList[index]),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
