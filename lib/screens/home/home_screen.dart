import 'package:ecommerce_app/managers/category_images_manager.dart';
import 'package:ecommerce_app/tools/custom_sized_box.dart';
import 'package:ecommerce_app/tools/i18n_extension/home_screen_i18n.dart';
import 'package:ecommerce_app/widgets/components/category_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/components/product_grid.dart';
import '../../widgets/components/top_titles.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(title: 'Storia', subtitle: ''),
              16.hg,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  focusNode: _focusNode[0],
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
                child: Row(
                  children: [
                SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  itemCount: categoryImagesList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final imageUrl = categoryImagesList.map((e) => e.image).toList();
                    return CategoryCards(imageUrl[index]!, (){
                      print("image: $index");
                    });

                  },
                ),
              ),
                  ]),
              ),
              TopTitles(title: "Mais vendidos".i18n, subtitle: ''),
              /*Best Sellers*/
              const ProductGrid(title: 'Banana Prata', urlImage: 'https://frutasbrasilsul.com.br/wp-content/uploads/banana-nanica.png', price: 2.5,)
            ],
          ),
        ),
      ),
    );
  }
}
