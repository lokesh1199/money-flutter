import 'package:flutter/material.dart';
import 'package:money/models/user.dart';
import 'package:money/services/authenticate_service.dart';
import 'package:money/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamProvider<User?>.value(
        initialData: null,
        value: AuthenticateService().user,
        child: Wrapper(),
      ),
    );
  }
}
