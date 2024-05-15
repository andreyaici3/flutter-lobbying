import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/colors.dart';
import 'package:lobbying/const/styles/fonts.dart';
import 'package:lobbying/data/commons/nav_key.dart';
import 'package:lobbying/data/commons/nav_utils.dart';
import 'package:lobbying/data/provider/tracking_provider.dart';
import 'package:lobbying/ui/widgets/buttons/button_primary.dart';
import 'package:lobbying/ui/widgets/dialog/progress_dialog.dart';
import 'package:lobbying/ui/widgets/dialog/sesi_dialog.dart';
import 'package:lobbying/ui/widgets/textfields/text_field_custom.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTrackScreen extends StatefulWidget {
  const AddTrackScreen({super.key});

  @override
  State<AddTrackScreen> createState() => _AddTrackScreenState();
}

class _AddTrackScreenState extends State<AddTrackScreen> {
  TextEditingController nama = TextEditingController();
  TextEditingController nopol = TextEditingController();
  TextEditingController nosurat = TextEditingController();

  String generateNoSurat() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('ddMMyyyy-kkmmss').format(now);
    return "PJL-$formattedDate";
  }

  Future<void> _handleSubmit(BuildContext context, datas) async {
    final trackProvider = Provider.of<TrackingProvider>(context, listen: false);
    try {
      ProgressDialogCustom.showLoading(context, NavKey.keyLoader);
      await Future.delayed(const Duration(seconds: 2), () {
        trackProvider.storeData(datas).then((value) {
          if (value == 302) {
            backScreen();
            SesiDialog.show(context, NavKey.keyLoader);
          } else {
            backScreen();

            if (value.data["success"]) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Berhasil Ditambahkan")));
              backScreen("reff");
            } else {
              backScreen("reff");
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Gagal Ditambahkan")));
            }
          }
        });
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    nosurat.text = generateNoSurat();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Data"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldCustom(
              title: "No Surat Jalan",
              controller: nosurat,
              titleTextStyle: TextStyleL.primaryTextStyle.copyWith(
                color: ColorsL.primaryTextColor,
              ),
              hintText: "No Surat Jalan",
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldCustom(
              title: "Nomor Polisi",
              controller: nopol,
              titleTextStyle: TextStyleL.primaryTextStyle.copyWith(
                color: ColorsL.primaryTextColor,
              ),
              hintText: "Nomor Polisi, Cth. E 1111 ZQ",
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldCustom(
              title: "Nama Driver",
              controller: nama,
              titleTextStyle: TextStyleL.primaryTextStyle.copyWith(
                color: ColorsL.primaryTextColor,
              ),
              hintText: "Nama Driver",
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonPrimary(
              title: "Tambah Data",
              size: 40,
              onTap: () {
                Map<String, dynamic> datas = {
                  "nama": nama.text,
                  "nopol": nopol.text,
                  "nosurat": nosurat.text
                };
                _handleSubmit(NavKey.navKey.currentState!.context, datas);
              },
            ),
          ],
        ),
      ),
    );
  }
}
