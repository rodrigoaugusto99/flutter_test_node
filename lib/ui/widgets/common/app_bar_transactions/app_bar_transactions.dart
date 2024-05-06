import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'app_bar_transactions_model.dart';

class AppBarTransactions extends StackedView<AppBarTransactionsModel>
    implements PreferredSizeWidget {
  final String title;
  final Function()? onRefresh;
  Function()? onBack;
  AppBarTransactions({
    super.key,
    required this.title,
    required this.onRefresh,
    this.onBack,
  });

  @override
  Widget builder(
    BuildContext context,
    AppBarTransactionsModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: double.infinity,
        color: Colors.black38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBack ?? viewModel.back,
              child: const Icon(
                Icons.arrow_back,
                size: 40,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: onRefresh,
              child: const Icon(
                Icons.refresh,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  AppBarTransactionsModel viewModelBuilder(
    BuildContext context,
  ) =>
      AppBarTransactionsModel();

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
/*
SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: double.infinity,
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back),
            Text(title),
            const Icon(Icons.refresh)
          ],
        ),
      ),
    );
 */