import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
      appBar: AppBar(
        title: const Text('transactions'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: viewModel.getAllTransactions1,
              child: const Text('Atualizar'),
            ),
            if (viewModel.transactions != null)
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.transactions!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Text('id: ${viewModel.transactions![index].id}'),
                            Text(
                                'Titulo: ${viewModel.transactions![index].title}'),
                            Text(
                                'Valor: ${viewModel.transactions![index].amount}'),
                          ],
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
