import 'package:flutter/material.dart';
import 'package:test_node_flutter/ui/common/app_colors.dart';
import 'package:test_node_flutter/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'create_transaction_dialog_model.dart';

class CreateTransactionDialog
    extends StackedView<CreateTransactionDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CreateTransactionDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateTransactionDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(request.title ?? ''),
              TextFormField(
                controller: viewModel.titleController,
                decoration: const InputDecoration(hintText: 'titulo'),
                focusNode: viewModel.focusNode,
              ),
              TextFormField(
                controller: viewModel.amountController,
                decoration:
                    const InputDecoration(hintText: 'Valor da transacao'),
              ),
              TextFormField(
                controller: viewModel.typeController,
                decoration:
                    const InputDecoration(hintText: 'tipo da transacao'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: viewModel.onPressed,
                    child: const Text('confirmar'),
                  ),
                  ElevatedButton(
                    onPressed: viewModel.back,
                    child: const Text('voltar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  CreateTransactionDialogModel viewModelBuilder(BuildContext context) =>
      CreateTransactionDialogModel(
        completer: completer,
      );
}
