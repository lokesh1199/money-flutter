import 'package:flutter/material.dart';
import 'package:money/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({Key? key, required this.transaction})
      : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final String time =
        DateFormat("dd MMM yyyy").format(DateTime.parse(transaction.time));
    final String _msg = transaction.money >= 0 ? 'Credited' : 'Debited';

    final Color _debitedContainerColor = Color(0xffEFCACF);
    final Color _creditedContainerColor = Color(0xffCDDFF4);

    final Color _debitedTextColor = Color(0xffF2979E);
    final Color _creditedTextColor = Color(0xff1699D7);

    final bool isCredited = transaction.money >= 0;

    final String symbol = isCredited ? '+' : '-';

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      height: 120.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: isCredited ? _creditedContainerColor : _debitedContainerColor,
      ),
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              transaction.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              _msg,
              style: TextStyle(
                color: isCredited ? _creditedTextColor : _debitedTextColor,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symbol + transaction.money.toString(),
              style: TextStyle(
                color: isCredited ? _creditedTextColor : _debitedTextColor,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              time,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
