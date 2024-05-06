import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_node_flutter/ui/common/app_colors.dart';
import 'package:test_node_flutter/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'create_transaction_dialog_model.dart';

class CreateTransactionDialog
    extends StackedView<CreateTransactionDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CreateTransactionDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateTransactionDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    request.title ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: viewModel.back,
                      child: const CircleAvatar(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: viewModel.titleController,
                focusNode: viewModel.focusNode,
                hintText: 'Title',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: viewModel.amountController,
                hintText: 'Transaction value',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomRadio(
                      selectedColor: const Color(0xff66BB6A),
                      text: 'Credit',
                      isSelected: viewModel.isCreditSelected,
                      unSelectedColor: const Color.fromARGB(255, 201, 235, 202),
                      onSelected: (text) => viewModel.onSelected(text),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomRadio(
                      selectedColor: const Color(0xffEF5350),
                      text: 'Debit',
                      isSelected: viewModel.isDebitSelected,
                      unSelectedColor: const Color.fromARGB(255, 233, 183, 183),
                      onSelected: (text) => viewModel.onSelected(text),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  fixedSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 54, 54, 53),
                      width: 1.0,
                    ),
                  ),
                  backgroundColor: Colors.black,
                  elevation: 0,
                ),
                onPressed: viewModel.onPressed,
                child: const Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 23),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CreateTransactionDialogModel viewModelBuilder(BuildContext context) =>
      CreateTransactionDialogModel(
        completer: completer,
      );
}

class CustomRadio extends StatelessWidget {
  final String text;
  final Color selectedColor;
  final Color unSelectedColor;
  bool isSelected;
  final Function(String) onSelected;

  CustomRadio({
    super.key,
    required this.text,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(text),
      child: AnimatedContainer(
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? selectedColor : unSelectedColor,
        ),
        duration: const Duration(milliseconds: 150),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
