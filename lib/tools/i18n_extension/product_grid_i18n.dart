import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("pt_br") +
      {
        "pt_br": "COMPRAR",
        "en_us": "BUY"
      }+
      {
        "pt_br": "O que deseja fazer com ",
        "en_us": "What do you want to do with "
      }+
      {
        "pt_br": "Adicionar p/\ncarrinho",
        "en_us": "Add to cart"
      }+
      {
        "pt_br": "Ir para o \npagamento",
        "en_us": "Go to payment"
      };


  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

}