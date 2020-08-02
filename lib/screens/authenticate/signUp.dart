import 'package:brew/services/auth.dart';
import 'package:brew/shared/constants.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              title: Text('Sign up to Brew Crew'),
              // centerTitle: true,
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person, color: Colors.grey[350]),
                    label: Text('Sign In',
                        style: TextStyle(
                          color: Colors.grey[350],
                        )))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });

                            dynamic result =
                                await _auth.registerWithEmailPassword(
                                    email.trim(), password.trim());
                            if (result == null) {
                              setState(() {
                                error = 'Enter a valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text('Register',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        color: Colors.brown[600],
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Text(error, style: TextStyle(color: Colors.red[400]))
                    ],
                  )),
            ));
  }
}
