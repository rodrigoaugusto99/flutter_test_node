import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_node_flutter/app/app.locator.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(
    SnackbarConfig(
      //icon: const CircularProgressIndicator(),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      snackStyle: SnackStyle.GROUNDED,
      snackPosition: SnackPosition.BOTTOM,
    ),
  );
}
