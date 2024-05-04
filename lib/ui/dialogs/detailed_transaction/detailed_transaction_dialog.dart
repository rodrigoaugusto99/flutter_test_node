import 'package:flutter/material.dart';
import 'package:test_node_flutter/models/transaction_model.dart';
import 'package:test_node_flutter/ui/common/app_colors.dart';
import 'package:test_node_flutter/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'detailed_transaction_dialog_model.dart';

const double _graphicSize = 60;

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
    final data = request.data as TransactionModel;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey,
          child: Column(
            children: [
              Text('id: ${data.id}'),
              Text('Titulo: ${data.title}'),
              Text('Valor: ${data.amount}'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  DetailedTransactionDialogModel viewModelBuilder(BuildContext context) =>
      DetailedTransactionDialogModel();
}
