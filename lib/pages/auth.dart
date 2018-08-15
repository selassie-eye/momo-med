import 'package:flutter/material.dart';

import '../widgets/title.dart';

class AuthPage extends StatelessWidget {
  final Function userGet;
  final Function userSet;
  AuthPage(this.userGet, this.userSet);

  void _updateInput(String key, dynamic value) { userSet(key, value); }

  TextField _inputField(String key, [bool isNumber = false]) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: key),
      onChanged: (String value) => isNumber ? _updateInput(key, int.parse(value)) : _updateInput(key, value)
    );
  }

  Container _inputButton(String text, BuildContext context) {
    return Container(margin: EdgeInsets.all(10.0), child: RaisedButton(
        child: Text(text),
        onPressed: () => Navigator.pushReplacementNamed(context, '/main-menu') 
    ),);
  }

  Container _privacySwitch(String key) {
    return Container(margin: EdgeInsets.all(10.0), child: SwitchListTile(
      value: userGet(key),
       title: Text('Do you accept the Terms of Use and our Privacy Policy?'),
      onChanged: (bool value) => _updateInput(key, value)
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TitleBar('Welcome').build(context),
      body: Container(margin: EdgeInsets.all(10.0), child: Column(
        children: <Widget>[
          Expanded(child: ListView(children: <Widget>[
            _inputField('First Name'),
            _inputField('Last Name'),
            _inputField('Username'),
            _inputField('Password'),
            _inputField('ZIP', true),
            _privacySwitch('Privacy'),
            _inputButton('Submit', context),
          ],),),
        ],
      ),)
    );
  }
}



