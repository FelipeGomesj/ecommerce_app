import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("pt_br") +
      {
        "pt_br" : "Bem-vindo de volta.",
        "en_us" : "Welcome back."
      }+
      {
        "pt_br": "Senha",
        "en_us": "Password"
      }+
      {
        "pt_br":"Não tem uma conta?",
        "en_us":"Don't have an account?"
      }+
      {
        "pt_br":"Crie uma conta",
        "en_us":"Create an account"
      };


  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

}