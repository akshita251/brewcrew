import 'package:brew/services/auth.dart';
import 'package:brew/shared/constants.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text('Sign in to Brew Crew'),
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person, color: Colors.grey[350]),
                    label: Text('Register',
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
                        validator: (value) =>
                            value.isEmpty ? 'Enter an email' : null,
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
                        validator: (value) => value.length < 6
                            ? 'Paswword must have more than 6 characters'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.signInWithEmailPassword(
                                    email.trim(), password.trim());
                            if (result == null) {
                              setState(() {
                                error = 'Enter a valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text('Sign in',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        color: Colors.brown[600],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(error, style: TextStyle(color: Colors.red[400]))
                    ],
                  )),
            ));
  }
}
