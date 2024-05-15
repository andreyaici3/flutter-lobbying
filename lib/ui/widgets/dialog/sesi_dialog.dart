import 'package:flutter/material.dart';
import 'package:lobbying/data/commons/nav_utils.dart';
import 'package:lobbying/ui/pages/auth/sign_in_screen.dart';

class SesiDialog {
  static Future<void> show(BuildContext context, GlobalKey key) async {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        nextScreenRemoveUntil(const SignInScreen());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Sesi Habis"),
      content: const Text("Silahkan Login Ulang"),
      actions: [
        okButton,
      ],
    );
    return showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
