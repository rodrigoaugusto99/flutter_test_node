import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:test_node_flutter/app/app.dialogs.dart';
import 'package:test_node_flutter/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'package:test_node_flutter/models/transaction_model.dart';

class TransactionsViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  List<TransactionModel>? transactions;
  List<TransactionModel>? filteredTransactions;
  TransactionModel? detailedTransaction;

  String sessionId = '';

//o retorno eh uma lista de transactions
// [
//   {"id": 1, "amount": 200},
//   {"id": 2, "amount": 300},
//   {"id": 3, "amount": 600},
//  ]
  void getAllTransactions1() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3333/transactions'),
        headers: {
          'set-cookie': sessionId,
        },
      ).timeout(const Duration(seconds: 2));

      // updateCookie(response);

      if (response.statusCode == 200) {
/*o response.body eh uma lista. Lista de OBJETOS JSON. */
        List jsonList = json.decode(response.body);
        log(jsonList.toString());
        /*Por que se colocar dynamic list, da erro de 
       type 'List<dynamic>' is not a subtype of type 'List<TransactionModel>? ?
        o dyanmic nao pode ser um List tbm, meu Deus?*/

/*aplicando a funcao TransactionModel.fromMap() para cada item da lista.
Essa funcao converte cada objeto json em um objeto TransactionModel. */

        transactions =
            jsonList.map((item) => TransactionModel.fromMap(item)).toList();

        notifyListeners();
      } else {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception('Erro ao carregar post');
      }
    } catch (e) {
      log('Erro inesperado: $e');
    }
  }

//o retorno eh um objeto 'transactions', contendo uma lista de transactions
// {
//    transactions: [
//        {"id": 1, "amount": 200},
//        {"id": 2, "amount": 300},
//        {"id": 3, "amount": 600},
//     ]
//}
  void getAllTransactions2() async {
    try {
      final response = await http
          .get(Uri.parse('http://10.0.2.2:3333/transactions'))
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        /*eu ja sei que vem 'transactions': [{id: xx, amount, yy}]/
Entao por que nao pode ser Map<String, List>>? */
        final Map<String, dynamic> responseBody = json.decode(response.body);
        log(responseBody.toString());
        final List<dynamic> jsonList = responseBody['transactions'];
        transactions =
            jsonList.map((item) => TransactionModel.fromMap(item)).toList();

        notifyListeners();
      } else {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception(
            'Erro na solicitação: statusCode ${response.statusCode}');
      }
    } catch (e) {
      log('Erro inesperado: $e');
    }
  }

  void createTransaction() async {
    final responseDialog = await _dialogService.showCustomDialog(
      variant: DialogType.createTransaction,
      title: 'Crie sua transacao',
    );

    if (responseDialog == null || responseDialog.data == null) {
      return;
    }

    if (responseDialog.confirmed) {
      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:3333/transactions'),
          headers: {
            'Content-Type': 'application/json',
            'set-cookie': sessionId
          },
          body: jsonEncode({
            'title': responseDialog.data['title'],
            'amount': int.parse(responseDialog.data['amount']),
            'type': responseDialog.data['type'],
          }),
        );
        if (response.statusCode == 201) {
          log('Transacao feita com sucesso');
          // Verifica se a resposta possui cabeçalhos de cookies
          if (response.headers.containsKey('set-cookie')) {
            String rawCookies = response.headers['set-cookie']!;

            // Faça o parse dos cookies
            Map<String, String> cookies = parseCookies(rawCookies);

            // Agora você pode usar os cookies conforme necessário
            sessionId = cookies['sessionId'] ?? '';
            log('sessionId: $sessionId');
          }
        } else {
          log('Erro na criacao da transacao');
        }
        getAllTransactions1();
      } on Exception catch (e) {
        log('erro: $e');
      }
    } else {
      log('Operacao cancelada');
    }
  }

  void navToDetailedTransaction(String id) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3333/transactions/$id'),
        headers: {
          'set-cookie': sessionId,
        },
      ).timeout(const Duration(seconds: 2));

      if (response.statusCode == 401) {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception('nao autorizado!');
      }

      if (response.statusCode == 200) {
        dynamic didi = json.decode(response.body);
        log(didi.toString());
        detailedTransaction = TransactionModel.fromMap(didi);
        log(detailedTransaction.toString());
        //todo: capturar erro de unauthorized do api

        await _dialogService.showCustomDialog(
          variant: DialogType.detailedTransaction,
          data: detailedTransaction,
        );

        notifyListeners();
      } else {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception('Erro ao carregar post');
      }
    } catch (e) {
      log('Erro inesperado: $e');
    }
  }

  // Função para fazer o parse dos cabeçalhos de cookies
  Map<String, String> parseCookies(String rawCookies) {
    Map<String, String> cookies = {};
    List<String> cookiePairs = rawCookies.split(';');
    for (String cookiePair in cookiePairs) {
      List<String> keyValue = cookiePair.trim().split('=');
      if (keyValue.length == 2) {
        String key = keyValue[0];
        String value = keyValue[1];
        cookies[key] = value;
      }
    }
    return cookies;
  }
}
