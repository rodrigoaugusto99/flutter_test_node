import 'package:flutter/material.dart';
import 'package:test_node_flutter/models/transaction_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'detailed_transaction_dialog_model.dart';

class DetailedTransactionDialog
    extends StackedView<DetailedTransactionDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DetailedTransactionDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DetailedTransactionDialogModel viewModel,
    Widget? child,
  ) {
    final data = request.data as List<TransactionModel>;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return DetailedTransactionsWidget(data: data[index]);
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  DetailedTransactionDialogModel viewModelBuilder(BuildContext context) =>
      DetailedTransactionDialogModel();
}

class DetailedTransactionsWidget extends StatelessWidget {
  const DetailedTransactionsWidget({
    super.key,
    required this.data,
  });

  final TransactionModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Detalhes da transacao',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'ID: ${data.id}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Título: ${data.title}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Valor: ${data.amount}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
