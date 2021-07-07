import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money/constants/input_decoration.dart';
import 'package:money/models/user.dart';
import 'package:money/screens/authenticate/register.dart';
import 'package:money/screens/loading.dart';
import 'package:money/services/authenticate_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    final TextStyle _headingTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 40.0,
    );

    final TextStyle _subHeadingTextStyle = TextStyle(
      color: Colors.grey,
      fontSize: 20.0,
    );

    void _submit() async {
      if (!(_email.isEmpty || _password.isEmpty)) {
        setState(() {
          _isLoading = true;
        });
        User? user = await AuthenticateService().signIn(_email, _password);
        if (user == null) {
          setState(() {
            _error = 'Invalid Email or Password';
            _isLoading = false;
          });
        }
      }
    }

    return _isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 100.0),
                    Text(
                      'Hey,',
                      style: _headingTextStyle,
                    ),
                    Text(
                      'Login Now.',
                      style: _headingTextStyle,
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Text(
                          'If you are new / ',
                          style: _subHeadingTextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Register();
                            }));
                          },
                          child: Text(
                            'Create account',
                            style: _subHeadingTextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (val) => setState(() => _email = val),
                      decoration:
                          loginTextInputDecoration.copyWith(labelText: 'Email'),
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      obscureText: true,
                      onChanged: (val) => setState(() => _password = val),
                      decoration: loginTextInputDecoration.copyWith(
                          labelText: 'password'),
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: GestureDetector(
                        onTap: _submit,
                        child: Container(
                          height: 60.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            color: Color(0xff273D65),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Center(
                      child: Text(
                        _error,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
