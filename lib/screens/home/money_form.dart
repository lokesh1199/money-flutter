import 'package:flutter/material.dart';
import 'package:money/constants/input_decoration.dart';
import 'package:money/models/transaction.dart';
import 'package:money/services/database_service.dart';

class MoneyForm extends StatefulWidget {
  const MoneyForm({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _MoneyFormState createState() => _MoneyFormState();
}

class _MoneyFormState extends State<MoneyForm> {
  int? _money;
  String? _description;
  bool? _isCredit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color _debitedContainerColor = Color(0xffF2979E);
  Color _creditedContainerColor = Color(0xff1699D7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff273D65),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Add transaction',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            textInputDecoration.copyWith(labelText: 'Amount'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter amount' : null,
                        onChanged: (val) =>
                            setState(() => _money = int.parse(val)),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Description',
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter amount' : null,
                        onChanged: (val) => setState(() => _description = val),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _MyButton(
                            icon: Icons.add_rounded,
                            onTap: () {
                              setState(() {
                                _isCredit = true;
                                _creditedContainerColor = Color(0xff273D65);
                                _debitedContainerColor = Color(0xffF2979E);
                              });
                            },
                            msg: 'Credit',
                            color: _creditedContainerColor,
                          ),
                          SizedBox(width: 50.0),
                          _MyButton(
                            icon: Icons.remove_rounded,
                            onTap: () {
                              setState(() {
                                _isCredit = false;
                                _debitedContainerColor = Color(0xff273D65);
                                _creditedContainerColor = Color(0xff1699D7);
                              });
                            },
                            msg: 'Debit',
                            color: _debitedContainerColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate() &&
                              _isCredit != null) {
                            Navigator.pop(context);
                            await DatabaseService(widget.uid)
                                .addTransaction(Transaction(
                              money: _money! * (_isCredit! ? 1 : -1),
                              description: _description!,
                              time: DateTime.now().toString(),
                            ));
                          }
                        },
                        child: Container(
                          height: 50.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyButton extends StatelessWidget {
  const _MyButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.msg,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final Function() onTap;
  final String msg;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
