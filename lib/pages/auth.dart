import 'package:flutter/material.dart';

import '../widgets/title.dart';
import './main-menu.dart';
import '../search.dart';

class AuthPage extends StatelessWidget {

  Container _inputField(String init) {
    return Container(margin: EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: init,
      )
    );
  }

  Container _inputButton(String text, BuildContext context) {
    return Container(margin: EdgeInsets.all(10.0),
      child: RaisedButton(
        child: Text(text),
        onPressed: () => Navigator.pushReplacementNamed(context, '/main-menu')
      ),
    );
  }
  
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: TitleBar('Welcome').build(context),
        body: Column(
          children: <Widget>[
            Expanded(child: ListView(children: <Widget>[
              _inputField('First Name'),
              _inputField('Last Name'),
              _inputField('Username'),
              _inputField('Password'),
              _inputField('ZIP Code'),
              _inputButton('Submit', context),
            ],),),
          ],
        )
      );
    }
}