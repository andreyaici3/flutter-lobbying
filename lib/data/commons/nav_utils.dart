import 'package:flutter/material.dart';
import 'package:lobbying/data/commons/nav_key.dart';

Future nextScreen(page) async {
  return await Navigator.push(NavKey.navKey.currentState!.context,
      MaterialPageRoute(builder: (context) => page));
}

void backScreen([dynamic value]) {
  Navigator.pop(NavKey.navKey.currentState!.context, value);
}

void nextScreenRemoveUntil(page) {
  Navigator.pushAndRemoveUntil(NavKey.navKey.currentState!.context,
      MaterialPageRoute(builder: (context) => page), (route) => false);
}
