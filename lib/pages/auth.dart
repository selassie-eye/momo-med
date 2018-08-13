import 'package:flutter/material.dart';

import '../widgets/title.dart';
import './main-menu.dart';
import '../search.dart';

class AuthPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() { return _AuthPageState(); }

}

class _AuthPageState extends State<AuthPage> {
  Map<String, dynamic> _userInput;

  @override
  void initState() {
    super.initState();
    _createInputMap();
  }

  void _createInputMap() {
    // List of User Input Fields
    _userInput = {
      'First Name': '',
      'Last Name': '',
      'Username': '',
      'Password': '',
      'ZIP': 0,
      'Privacy': false
    };
  }

  void _updateInput(String key, dynamic value) {
    if (_userInput.containsKey(key)) _userInput[key] = value;
  }

  TextField _inputField(String key, [bool isNumber = false]) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: key),
      onChanged: (String value) { setState(() {
        isNumber ? _updateInput(key, int.parse(value)) : _updateInput(key, value);
      }); }
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
      value: _userInput[key],
       title: Text('Do you accept the Terms of Use and our Privacy Policy?'),
      onChanged: (bool value) { setState(() {
        _updateInput(key, value);
      }); }
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



