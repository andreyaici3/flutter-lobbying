import 'package:flutter/material.dart';

class NavKey {
  NavKey._();

  static final navKey = GlobalKey<NavigatorState>();
  static final keyLoader = GlobalKey<State>();
  static bool isInLogin = false;
}
