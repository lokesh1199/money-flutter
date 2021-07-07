import 'package:flutter/material.dart';
import 'package:money/models/transaction.dart';
import 'package:money/models/user.dart';
import 'package:money/screens/home/body.dart';
import 'package:money/screens/home/money_form.dart';
import 'package:money/services/database_service.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return Scaffold(
      backgroundColor: Color(0xff273D65),
      body: StreamProvider<List<Transaction>>.value(
        initialData: [],
        value: DatabaseService(user!.uid).transcations,
        child: SafeArea(child: Body()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MoneyForm(uid: user.uid);
          }));
        },
        backgroundColor: Color(0xff273D65),
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
