import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_node_flutter/app/app.locator.dart';

class CreateTransactionDialogModel extends BaseViewModel {
  final Function(DialogResponse response)? completer;

  final amountController = TextEditingController();
  final typeController = TextEditingController();
  final titleController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  CreateTransactionDialogModel({this.completer}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  final _navigationService = locator<NavigationService>();

  void back() {
    _navigationService.back();
  }

  void onPressed() {
    if (!formKey.currentState!.validate()) {
      log('valores invalidos');
      return;
    }
    if (completer != null) {
      completer!(DialogResponse(
        confirmed: true,
        data: {
          'title': titleController.text,
          'amount': amountController.text,
          'type': typeController.text,
        },
      ));
    }
  }
}
