import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("pt_br") +
      {
        "pt_br": "Carregando...",
        "en_us": "Loading..."
      }+
      {
        "pt_br": "Sua senha é muito fraca.",
        "en_us": "Your password is too weak"
      }+
      {
        "pt_br": "Seu e-mail é inválido",
        "en_us": "Your e-mail is invalid"
      }+
      {
        "pt_br": "E-mail já está sendo utilizado em outra conta.",
        "en_us": "E-mail is already being used in another account."
      }+
      {
        "pt_br": "Seu e-mail é inválido.",
        "en_us": "Invalid Credential."
      }+
      {
        "pt_br": "Sua senha está incorreta.",
        "en_us": "Your password is wrong"
      }+
      {
        "pt_br": "Não há usuário com este e-mail.",
        "en_us": "No users with this email"
      }+
      {
        "pt_br": "Este usuário foi desabilitado.",
        "en_us": "This users is disabled"
      }+
      {
        "pt_br": "Muitas solicitações. Tente novamente mais tarde.",
        "en_us": "Too many requests. Try again later."
      }+
      {
        "pt_br": "Operação não permitida.",
        "en_us": "Operation Not Allowed"
      }+
      {
        "pt_br": "Um erro indefinido ocorreu: ",
        "en_us": "An undefined error occurred"
      }+
      {
        "pt_br": "O E-mail está vazio",
        "en_us": "Email is Empty"
      }+
      {
        "pt_br": "Ambos os campos estão vazios",
        "en_us": "Both fields are empty"
      }+
      {
        "pt_br": "Todos os campos estão vazios",
        "en_us": "All fields are empty"
      }+
      {
        "pt_br": "O nome está vazio",
        "en_us": "Name field is empty"
      }+
      {
        "pt_br": "O número de celular ou telefone está vazio",
        "en_us": "Phone number field is empty"
      }+
      {
        "pt_br": "A senha está vazia",
        "en_us": "Password is empty"
      };


  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

}