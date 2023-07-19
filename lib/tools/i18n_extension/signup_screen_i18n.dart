import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("pt_br") +
      {
        "pt_br" : "Criar uma Conta",
        "en_us" : "Create Account"
      }+
      {
        "pt_br": "Nome",
        "en_us": "Name"
      }+
      {
        "pt_br": "Senha",
        "en_us": "Password"
      }+
      {
        "pt_br": "Bem-vindo à Loja",
        "en_us": "Welcome to the Store"
      }+
      {
        "pt_br": "Criar Conta",
        "en_us": "Create Account"
      }+
      {
        "pt_br": "Número (com DDD)",
        "en_us": "Number (with area code)"
      }+
      {
        "pt_br": "Já possui uma conta?",
        "en_us": "Already have an account?"
      };


  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

}