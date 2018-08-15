import 'package:flutter/material.dart';

class TitleBar extends AppBar {
  final String _title;
  TitleBar(this._title);

  Widget build(BuildContext context, [List<String> tabs = const [], bool isSearch = false]) {
      return AppBar(
        title: Text(_title),
        centerTitle: false,
        bottom: (tabs.length > 0) ? TabBar(
          tabs: tabs.map((String t) => Tab(text: t)).toList()
        ) : null,
        actions: isSearch ? <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) => Navigator.pushNamed(context, value),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '/adv-search',
                child: Text('Advanced Search')
              )
            ],
          )
        ] : null,
      );
    }
}