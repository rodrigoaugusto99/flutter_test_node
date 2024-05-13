import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_node_flutter/app/app.locator.dart';
import 'package:test_node_flutter/app/app.router.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToTransactionsPage() {
    _navigationService.navigateToTransactionsView();
  }

  void navigateToPlayground() {
    _navigationService.navigateToPlaygroundView();
  }
}
