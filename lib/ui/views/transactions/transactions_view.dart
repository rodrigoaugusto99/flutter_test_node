import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        onSummary: viewModel.getSummary,
        title: 'Transactions',
        onRefresh: viewModel.getAllTransactions1,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ProjectsSearchBar(
                    controller: viewModel.searchDatabaseController,
                    onTap: viewModel.clear,
                  ),
                ),
                ElevatedButton(
                  onPressed: viewModel.searchOnDatabase,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            ProjectsSearchBar(
              controller: viewModel.searchListController,
              onTap: viewModel.clear,
              onChanged: (value) => viewModel.onChangedSearch(value),
            ),
            if (viewModel.filteredTransactions.isEmpty &&
                viewModel.searchListController.text.isNotEmpty)
              const Text('sem resultado'),
            if (viewModel.transactions != null)
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.filteredTransactions.isNotEmpty ||
                          viewModel.searchListController.text.isNotEmpty
                      ? viewModel.filteredTransactions.length
                      : viewModel.transactions!.length,
                  itemBuilder: (context, index) {
                    final transaction =
                        viewModel.filteredTransactions.isNotEmpty ||
                                viewModel.searchListController.text.isNotEmpty
                            ? viewModel.filteredTransactions[index]
                            : viewModel.transactions![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TransactionWidget(
                        amount: transaction.amount,
                        title: transaction.title,
                        onTap: () => viewModel.navToDetailedTransaction(
                          transaction.id,
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

class ProjectsSearchBar extends StatelessWidget {
  final Function(String)? onChanged;
  void Function()? onTap;
  TextEditingController? controller;
  ProjectsSearchBar({
    super.key,
    this.onChanged,
    required this.onTap,
    required this.controller,
  });
/*resolver: ao clicar no botao de pesquisar e voltar, fica com o focus em um dos textformfields,
a nao ser que tenha tirado o teclado apenas pelo .done (canto inferior direito) */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.purple,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            hintText: 'Pesquisar na lista da viewModel',
            hintStyle: const TextStyle(color: Colors.black),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Icon(Icons.close),
              ),
            ),
            suffixIconColor: Colors.black,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 14.0, color: Colors.black),
        ),
      ),
    );
  }
}
