// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/create_transaction/create_transaction_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';

enum DialogType {
  infoAlert,
  createTransaction,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.createTransaction: (context, request, completer) =>
        CreateTransactionDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
