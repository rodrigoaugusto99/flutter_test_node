import 'package:email_validator/email_validator.dart';

class Validators {
  static String? title(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira um titulo';
    }
    if (value.length < 3) {
      return 'Titulo inválido, insira mais de 3 caracteres';
    }
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira um valor';
    }
    if (int.tryParse(value) == null) {
      return 'Insira apenas números';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira seu e-mail';
    }
    if (!EmailValidator.validate(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira seu telefone';
    }
    if (value.length < 19) {
      return 'Número inválido';
    }
    return null;
  }

  static String? fullName(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.split(' ').length < 2 ||
        value.length < 6) {
      return 'Insira seu nome completo';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira seu nome';
    }
    if (value.length < 3) {
      return 'Nome inválido, insira mais de 3 caracteres';
    }
    return null;
  }

  static String? projectName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira o nome do projeto';
    }
    if (value.length < 3) {
      return 'Nome inválido, insira mais de 3 caracteres';
    }
    return null;
  }

  static cep(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira seu CEP';
    }
    if (value.length < 8) {
      return 'CEP inválido';
    }
    return null;
  }

  static birthDate(String? text) {
    if (text == null || text.isEmpty) {
      return 'Insira sua data de nascimento';
    }
    if (text.length < 10) {
      return 'Data inválida';
    }
    var date = text.split('/');
    if (date.length != 3) {
      return 'Data inválida';
    }
    var day = int.tryParse(date[0]);
    var month = int.tryParse(date[1]);
    var year = int.tryParse(date[2]);
    if (day == null || month == null || year == null) {
      return 'Data inválida';
    }
    if (day < 1 || day > 31) {
      return 'Dia inválido';
    }
    if (month < 1 || month > 12) {
      return 'Mês inválido';
    }
    if (year < 1900 || year > DateTime.now().year) {
      return 'Ano inválido';
    }
    return null;
  }

  static String? streetValidator(String? value) {
    if (value == null || value.isEmpty) return "Insira o nome da rua";
    if (value.length < 3) return "Rua inválida";
    return null;
  }

  static String? numberValidator(String? value) {
    if (value == null || value.isEmpty) return "Insira o número";
    if (value.isEmpty) return "Número inválido";
    return null;
  }

  static String? neighborhoodValidator(String? value) {
    if (value == null || value.isEmpty) return "Insira o bairro";
    if (value.length < 3) return "Bairro inválido";
    return null;
  }

  static String? cityValidator(String? value) {
    if (value == null || value.isEmpty) return "Insira a cidade";
    if (value.length < 3) return "Cidade inválida";
    return null;
  }

  static String? stateValidator(String? value) {
    if (value == null || value.isEmpty) return "Insira o estado";
    if (value.length < 2) return "Estado inválido";
    return null;
  }
}
