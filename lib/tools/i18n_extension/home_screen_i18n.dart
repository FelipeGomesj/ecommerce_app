import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("pt_br") +
      {
        "pt_br": "Pesquisar",
        "en_us": "Search"
      }+
      {
        "pt_br": "Categorias",
        "en_us": "Categories"
      }+
      {
        "pt_br": "Mais vendidos",
        "en_us": "Best Sellers"
      }+
      {
        "pt_br": "Desculpe, ainda não há produtos aqui... :(",
        "en_us": "Sorry, don't have any product here yet... :("
      };


  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

}