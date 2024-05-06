import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final String title;
  final int amount;
  final Function()? onTap;

  const TransactionWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Text(
              amount > 0 ? '+ $amount' : amount.toString(),
              style: TextStyle(
                color: amount > 0
                    ? const Color(0xff66BB6A)
                    : const Color(0xffEF5350),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
