import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("pt_br") +
      {
        "pt_br" : "COMPRAR",
        "en_us" : "BUY"
      }+
      {
        "pt_br" : "Adicionar P/ carrinho",
        "en_us" : "ADD TO CART"
      };


  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

}