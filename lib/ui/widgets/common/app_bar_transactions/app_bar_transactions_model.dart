import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_node_flutter/app/app.locator.dart';

class AppBarTransactionsModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void back() async {
    _navigationService.back();
  }
}
