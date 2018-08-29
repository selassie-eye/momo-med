import 'package:flutter/material.dart';

class WidgetFactory {
  static AppBar basicAppBar(String title) {
    return AppBar(
      title: Text(title),
    );
  }
}