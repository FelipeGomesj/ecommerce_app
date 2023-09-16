class CategoryImagesModel {
 // final String id;
  final List<String> images;

  CategoryImagesModel({
    //required this.id,
    required this.images,
  });

  factory CategoryImagesModel.fromMap(Map<String, dynamic> map) {
    return CategoryImagesModel(
      //id: map['id'] ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }
}