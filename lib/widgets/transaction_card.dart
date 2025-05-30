import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;

  const TransactionCard({
    super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF1d1b20),
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(transactionName),
                  Text(
                    '${expenseOrIncome == 'expense' ? '-' : '+ '}৳$money',
                    style: TextStyle(
                      color: expenseOrIncome == 'expense'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
