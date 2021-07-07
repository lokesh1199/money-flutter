import 'package:flutter/material.dart';
import 'package:money/models/transaction.dart';
import 'package:money/screens/home/transaction_list.dart';
import 'package:money/services/authenticate_service.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final List<Transaction> transactions =
        Provider.of<List<Transaction>>(context).reversed.toList();
    int _total = 0;

    transactions.forEach((element) {
      _total += element.money;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Balance',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    _total.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  await AuthenticateService().logOut();
                },
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0),
                Text(
                  'My Transactions',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: TransactionList(
                    transactions: transactions,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
