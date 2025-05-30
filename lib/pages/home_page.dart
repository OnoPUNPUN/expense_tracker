import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/add_button.dart';
import '../widgets/transaction_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double mainBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  List<Map<String, dynamic>> transactions = [];

  void _newTransaction() {
    List<String> transactionTypes = ['Expense', 'Income'];
    String? dropdownValue;
    TextEditingController amountController = TextEditingController();
    TextEditingController reasonController = TextEditingController();
    bool showAmountWarning = false;
    bool showReasonWarning = false;
    bool showTypeWarning = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('NEW TRANSACTION'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transaction Type'),
                      DropdownButton<String>(
                        hint: Text('Select type'),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setDialogState(() {
                            dropdownValue = newValue!;
                            showTypeWarning = false;
                          });
                        },
                        items: transactionTypes.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  if (showTypeWarning)
                    Text(
                      'Please select a transaction type',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount?',
                      errorText: showAmountWarning ? 'Please add amount' : null,
                    ),
                  ),
                  TextField(
                    controller: reasonController,
                    decoration: InputDecoration(
                      labelText: 'For what?',
                      errorText: showReasonWarning ? 'Please add reason' : null,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setDialogState(() {
                      showAmountWarning = amountController.text.isEmpty;
                      showReasonWarning = reasonController.text.isEmpty;
                      showTypeWarning = dropdownValue == null;
                    });

                    if (!showAmountWarning &&
                        !showReasonWarning &&
                        !showTypeWarning) {
                      double amount = double.parse(amountController.text);

                      setState(() {
                        if (dropdownValue == 'Income') {
                          mainBalance += amount;
                          totalIncome += amount;
                        } else if (dropdownValue == 'Expense') {
                          mainBalance -= amount;
                          totalExpense += amount;
                        }

                        transactions.add({
                          'transactionName': reasonController.text,
                          'money': amountController.text,
                          'expenseOrIncome': dropdownValue!.toLowerCase(),
                        });
                      });

                      Navigator.pop(context);
                    }
                  },
                  child: Text('Enter'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'B A L A N C E',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "৳${mainBalance.toStringAsFixed(1)}",
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_circle_up_rounded,
                                        color: Colors.green,
                                        size: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Income',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '৳${totalIncome.toStringAsFixed(1)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_circle_down_rounded,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Expense',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '৳${totalExpense.toStringAsFixed(1)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    transactionName: transactions[index]['transactionName'],
                    money: transactions[index]['money'],
                    expenseOrIncome: transactions[index]['expenseOrIncome'],
                  );
                },
              ),
            ),
            AddButton(function: _newTransaction),
          ],
        ),
      ),
    );
  }
}
