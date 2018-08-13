import 'package:flutter/material.dart';

class TitleBar extends AppBar {
  final String _title;
  TitleBar(this._title);

  Widget build(BuildContext context, [List<String> tabs = const []]) {
      return AppBar(
        title: Text(_title),
        centerTitle: false,
        bottom: (tabs.length > 0) ? TabBar(
          tabs: tabs.map((String t) => Tab(text: t)).toList()
        ) : null
      );
    }
}