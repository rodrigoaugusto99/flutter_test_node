import 'package:test_node_flutter/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:test_node_flutter/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:test_node_flutter/ui/views/home/home_view.dart';
import 'package:test_node_flutter/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_node_flutter/ui/dialogs/create_transaction/create_transaction_dialog.dart';
import 'package:test_node_flutter/ui/views/transactions/transactions_view.dart';
import 'package:test_node_flutter/ui/dialogs/detailed_transaction/detailed_transaction_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: TransactionsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: CreateTransactionDialog),
    StackedDialog(classType: DetailedTransactionDialog),
// @stacked-dialog
  ],
)
class App {}
