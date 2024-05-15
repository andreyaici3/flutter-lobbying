import 'package:flutter/material.dart';
import 'package:lobbying/data/commons/nav_key.dart';
import 'package:lobbying/ui/pages/auth/sign_in_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavKey.navKey,
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
    );
  }
}
