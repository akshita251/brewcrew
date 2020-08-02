import 'package:brew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Card(
          color: Colors.brown[100],
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/coffee_icon.png'),
              backgroundColor: Colors.brown[brew.strength],
              radius: 30.0,
            ),
            title: Text(brew.name),
            subtitle: brew.sugars == '1'
                ? Text(brew.sugars + ' spoon of sugar')
                : Text(brew.sugars + ' spoons of sugar'),
          )),
    );
  }
}
