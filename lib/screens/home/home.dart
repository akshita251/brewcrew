import 'package:brew/models/brew.dart';
import 'package:brew/screens/home/settings_form.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSertingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
              child: Container(
                child: SettingsForm(),
              ),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brew,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _showSertingsPanel();
              },
              icon: Icon(Icons.settings, color: Colors.grey[350]),
            ),
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person, color: Colors.grey[350]),
                label: Text('logout',
                    style: TextStyle(
                      color: Colors.grey[350],
                    ))),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee_bg.png'),
                    fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
