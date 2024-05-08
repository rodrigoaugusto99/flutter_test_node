import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:test_node_flutter/app/app.dialogs.dart';
import 'package:test_node_flutter/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'package:test_node_flutter/models/transaction_model.dart';

class TransactionsViewModel extends BaseViewModel {
  // TransactionsViewModel() {
  //   searchListController.addListener(() {
  //     if(searchListController.text.isEmpty){

  //     }
  //   });
  // }
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();

  List<TransactionModel>? transactions;
  List<TransactionModel> filteredTransactions = [];
  TransactionModel? detailedTransaction;

  //String sessionId = '';
  String sessionId = 'd3acc95d-1c4b-4bec-8c56-d427e58d7b87';

  TextEditingController searchListController = TextEditingController(text: '');
  TextEditingController searchDatabaseController =
      TextEditingController(text: '');

//o retorno eh uma lista de transactions
// [
//   {"id": 1, "amount": 200},
//   {"id": 2, "amount": 300},
//   {"id": 3, "amount": 600},
//  ]
  Future getAllTransactions1() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3333/transactions'),
        headers: {
          'set-cookie': sessionId,
        },
      ).timeout(const Duration(seconds: 2));

      // updateCookie(response);

      if (response.statusCode == 200) {
/*o response.body eh uma lista. Lista de OBJETOS JSON. 
1 - decodificando a string para uma lista de objetos JSON*/
        List jsonList = json.decode(response.body);
        log(jsonList.toString());
        /*Por que se colocar dynamic list, da erro de 
       type 'List<dynamic>' is not a subtype of type 'List<TransactionModel>? ?
        o dyanmic nao pode ser um List tbm, meu Deus?*/

/*2 - aplicando a funcao TransactionModel.fromMap() para cada item da lista.
Essa funcao converte cada objeto json em um objeto TransactionModel. */

        transactions =
            jsonList.map((item) => TransactionModel.fromMap(item)).toList();

        notifyListeners();
      } else {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Erro inesperado',
        message: e.toString(),
      );
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

/*1 - aqui eu coloquei pra retornar o objeto transactions ao inves do transactions sozinho,
ou seja, nao vai retornar mais uma lista de transactions, vai retornar um mapa com a key
transactions e com o seu conteudo, (lista), que colocamos como dynamic. 
*/
        final Map<String, dynamic> responseBody = json.decode(response.body);
        log(responseBody.toString());
        /*depois de transformamos pra um mapa de objetos json, vamos pegar o conteudo
        da chave transactions. Sabemos que o conteudo dela eh uma lista.  */
        final List<dynamic> jsonList = responseBody['transactions'];

        /*agora que temos finalmente a lista dos objetos que queremos, podemos mapear
        e transformar cada um em um transaction model. */
        transactions =
            jsonList.map((item) => TransactionModel.fromMap(item)).toList();

        notifyListeners();
      } else {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Erro inesperado',
        message: e.toString(),
      );
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
        final response = await http
            .post(
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
            )
            .timeout(const Duration(seconds: 2));
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
          throw Exception(response.reasonPhrase);
        }
        await getAllTransactions1();
      } on Exception catch (e) {
        _snackbarService.showSnackbar(
          title: 'Erro inesperado',
          message: e.toString(),
        );
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
        throw Exception(response.reasonPhrase);
      }

      if (response.statusCode == 200) {
        dynamic didi = json.decode(response.body);
        log(didi.toString());
        detailedTransaction = TransactionModel.fromMap(didi);
        log(detailedTransaction.toString());
        if (detailedTransaction != null) {
          await _dialogService.showCustomDialog(
            variant: DialogType.detailedTransaction,
            data: [detailedTransaction!],
          );

          notifyListeners();
        }
      } else {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception(error.toString());
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Erro inesperado',
        message: e.toString(),
      );
      log('Erro inesperado: $e');
    }
  }

  void getSummary() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3333/transactions/summary'),
        headers: {
          'set-cookie': sessionId,
        },
      ).timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        dynamic summary = json.decode(response.body);
        log(summary['summary']['amount'].toString());
        await _dialogService.showDialog(
          title: 'Amout by summary',
          description: summary['summary']['amount'].toString(),
        );

        notifyListeners();
      } else {
        log('Erro na solicitação: statusCode ${response.statusCode}');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Erro inesperado',
        message: e.toString(),
      );
      log('Erro inesperado: $e');
    }
  }

  void searchOnDatabase() async {
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:3333/transactions/?title=${searchDatabaseController.text}'),
      headers: {
        'set-cookie': sessionId,
      },
    ).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      log(jsonList.toString());

//final pra ser outra variavel e se diferenciar da variavel la de cima
//se nao colocar final, esse transaciton vai substituir a lista de todas as transactions.
      final transactions =
          jsonList.map((item) => TransactionModel.fromMap(item)).toList();

      //todo: se tiver resultado, mostrar num dialog.
// se nao vier resultado nenhum, entao o return aqui vai ser [], correto? averigue.
      log(transactions.toString(), name: 'Transactions');
      await _dialogService.showCustomDialog(
        variant: DialogType.detailedTransaction,
        data: transactions,
      );

      notifyListeners();
    } else {
      log('Erro na solicitação: statusCode ${response.statusCode}');
      throw Exception(response.reasonPhrase);
    }

    log(searchDatabaseController.text);
  }

  void clear() {
    searchDatabaseController.clear();
    searchListController.clear();
    filteredTransactions = [];
    notifyListeners();
  }

  void onChangedSearch(String value) {
    log(value);
    if (transactions != null) {
      filteredTransactions = transactions!
          .where((transactions) => transactions.title.contains(value))
          .toList();
      notifyListeners();
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
