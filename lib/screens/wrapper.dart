import 'package:flutter/material.dart';
import 'package:money/models/user.dart';
import 'package:money/screens/authenticate/authenticate.dart';
import 'package:money/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return user == null ? Authenticate() : Home();
  }
}
