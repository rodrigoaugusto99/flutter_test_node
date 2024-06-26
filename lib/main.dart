import 'package:flutter/material.dart';
import 'package:test_node_flutter/app/app.bottomsheets.dart';
import 'package:test_node_flutter/app/app.dialogs.dart';
import 'package:test_node_flutter/app/app.locator.dart';
import 'package:test_node_flutter/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_node_flutter/ui/setup_snackbar_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  setupSnackbarUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
