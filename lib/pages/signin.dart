import 'package:flutter/material.dart';

import '../widgets/widget-factory.dart';

class Signin extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _SigninState();
    }
}

class _SigninState extends State<Signin>{
  final _formKey = GlobalKey<FormState>();

  @override
    void initState() {
      super.initState();
    }

  Widget _buildForm(BuildContext context) {
    return Center(child: Form(
      key: _formKey,
      child: _buildFields(context)
    ),);
  }

  Widget _buildFields(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildUsernameField(),
        _buildPasswordField(),
        _buildButtonRow(context)
      ],
    );
  }

  Widget _buildUsernameField() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Username'),
        autofocus: true,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            child: Text('Login'),
            onPressed: () => Navigator.pushNamed(context, '/featured'),
          )
        ),
        Container(margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            child: Text('Sign up'),
            onPressed: () => Navigator.pushNamed(context, '/auth'),
          )
        ),
      ]
    );
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: WidgetFactory.basicAppBar('Sign In'),
        body: _buildForm(context)
      );
    }
}