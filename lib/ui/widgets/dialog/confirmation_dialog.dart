import 'package:flutter/material.dart';
import 'package:lobbying/data/commons/nav_key.dart';
import 'package:lobbying/data/commons/nav_utils.dart';
import 'package:lobbying/data/provider/tracking_provider.dart';
import 'package:lobbying/ui/widgets/dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class ConfirmationDialog {
  static Future show(BuildContext context, GlobalKey key, String id) async {
    Widget okButton = TextButton(
      child: const Text("Ya"),
      onPressed: () async {
        final trackProvider =
            Provider.of<TrackingProvider>(context, listen: false);
        try {
          backScreen();
          ProgressDialogCustom.showLoading(context, NavKey.keyLoader);
          await Future.delayed(const Duration(seconds: 2), () {
            trackProvider.deleteData(id).then((value) {
              backScreen("reff");
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Berhasil DiHapus")));
            });
          });
        } catch (error) {
          print(error);
        }
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Tidak"),
      onPressed: () {
        backScreen("false");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Konfirmasi"),
      content: const Text("Apakah Kamu Yakin"),
      actions: [
        okButton,
        cancelButton,
      ],
    );
    return showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
