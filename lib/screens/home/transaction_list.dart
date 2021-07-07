import 'package:flutter/material.dart';
import 'package:money/models/transaction.dart';
import 'package:money/screens/home/transcation_list_tile.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return TransactionListTile(
          transaction: transactions[index],
        );
      },
    );
  }
}
