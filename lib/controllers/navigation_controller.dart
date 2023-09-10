import 'package:flutter/material.dart';

class NavigationController extends ValueNotifier<int> {
  NavigationController() : super(0);

  void changePage(int page) {
    value = page;
  }

}
