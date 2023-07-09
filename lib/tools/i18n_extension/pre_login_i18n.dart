import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("pt_br") +
      {
        "pt_br" : "BEM-VINDO",
        "en_us" : "WELCOME"
      }+
      {
       "pt_br" : "Compre o que você precisar do conforto de sua casa.",
       "en_us" : "Buy what you need from the comfort of your home."
      };


  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

}