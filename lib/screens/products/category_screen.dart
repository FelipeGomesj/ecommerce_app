import 'package:ecommerce_app/configs/customColors.dart';
import 'package:ecommerce_app/models/category_images_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../managers/product_manager.dart';
import '../../widgets/components/product_grid.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(this.categoryImagesModel, {super.key});

  final CategoryImagesModel categoryImagesModel;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late String _category;

  @override
  Widget build(BuildContext context) {
    _category = widget.categoryImagesModel.category!;
    double _height = MediaQuery.of(context).size.height;
    return Consumer<ProductManager>(
        builder: (BuildContext context, productManager, Widget? child) =>
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Center(
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Categoria: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${_category[0].toUpperCase()}${_category.substring(1).toLowerCase()}s",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            //color: Colors.orange.shade700),
                          color: CustomColors.orangeTitle
                        ),
                      )
                    ]),
                  ),
                ),
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
              body: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    //bottom: _height <= 800 ? _height * 0.75 : _height * 0.6,
                    bottom: 32,
                    left: 8,
                    right: 8,
                    top: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: _height >= 800 ? 0.8 : 0.75,
                  //mainAxisExtent: _height * 0.3
                  //childAspectRatio: 0.8
                ),
                itemCount:
                    productManager.listCategoryProducts(_category).length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  List<ProductModel> categoryProducts =
                      productManager.listCategoryProducts(_category);
                  return ProductGrid(productModel: categoryProducts[index]);
                },
              ),
            ));
  }
// List<ProductModel> listCategoryProducts(String category){
//   final _productManager = Provider.of<ProductManager>(context);
//   final _productList = _productManager.products;
//   List<ProductModel> productCategoryList = [];
//   for(ProductModel product in _productList) {
//     if(product.type == category){
//       productCategoryList.add(product);
//     }
//   }
//   return productCategoryList;
// }
}
