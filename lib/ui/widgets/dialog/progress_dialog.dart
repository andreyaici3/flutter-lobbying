import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/colors.dart';

class ProgressDialogCustom {
  static Future<void> showLoading(BuildContext context, GlobalKey key) async {
    return showDialog(
        context: context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: SimpleDialog(
              key: key,
              backgroundColor: ColorsL.aliceBlue,
              children: const [
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Silahkan Tunggu....",
                          style: TextStyle(color: Colors.black),
                        )
                      ]),
                )
              ],
            ),
          );
        });
  }
}
