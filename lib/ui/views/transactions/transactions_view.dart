import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_node_flutter/components/transaction_widget.dart';
import 'package:test_node_flutter/ui/widgets/common/app_bar_transactions/app_bar_transactions.dart';

import 'transactions_viewmodel.dart';

class TransactionsView extends StackedView<TransactionsViewModel> {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TransactionsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBarTransactions(
        title: 'Transactions',
        onRefresh: viewModel.getAllTransactions1,
      ),
      body: Center(
        child: Column(
          children: [
            if (viewModel.transactions != null)
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.transactions!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TransactionWidget(
                        amount: viewModel.transactions![index].amount,
                        title: viewModel.transactions![index].title,
                        onTap: () => viewModel.navToDetailedTransaction(
                          viewModel.transactions![index].id,
                        ),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.createTransaction,
        child: const Icon(Icons.money_off_outlined),
      ),
    );
  }

  @override
  TransactionsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TransactionsViewModel();
}
