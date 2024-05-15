import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/colors.dart';
import 'package:lobbying/const/styles/fonts.dart';
import 'package:lobbying/data/commons/nav_key.dart';
import 'package:lobbying/data/commons/nav_utils.dart';
import 'package:lobbying/data/model/singledata_model.dart';
import 'package:lobbying/data/provider/tracking_provider.dart';
import 'package:lobbying/ui/widgets/buttons/button_primary.dart';
import 'package:lobbying/ui/widgets/dialog/progress_dialog.dart';
import 'package:lobbying/ui/widgets/textfields/text_field_custom.dart';
import 'package:provider/provider.dart';

class UpdateTrackScreen extends StatefulWidget {
  final int id;
  final int suhu;
  const UpdateTrackScreen({
    super.key,
    required this.id,
    required this.suhu,
  });

  @override
  State<UpdateTrackScreen> createState() => _UpdateTrackScreenState();
}

class _UpdateTrackScreenState extends State<UpdateTrackScreen> {
  TextEditingController suhuController = TextEditingController();
  String path = "path";
  File? file;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final trackingProvider =
        Provider.of<TrackingProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Data"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder(
              future: trackingProvider.getDataById(widget.id),
              builder: (context, snapshot) {
                SingleDataModel? single;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  single = null;
                } else {
                  single = SingleDataModel.fromJson(snapshot.data?.data);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Informasi Data",
                      style: TextStyleL.primaryTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Divider(),
                    RichText(
                      text: TextSpan(
                        text: "Nama Supir: ",
                        style: TextStyleL.primaryTextStyle
                            .copyWith(color: Colors.black, fontSize: 13),
                        children: [
                          TextSpan(
                            text: single == null ? "" : single.data.driver,
                            style: TextStyleL.primaryTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "No Polisi: ",
                        style: TextStyleL.primaryTextStyle
                            .copyWith(color: Colors.black, fontSize: 13),
                        children: [
                          TextSpan(
                            text: single == null ? "" : single.data.noPol,
                            style: TextStyleL.primaryTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "No Surat Jalan: ",
                        style: TextStyleL.primaryTextStyle
                            .copyWith(color: Colors.black, fontSize: 13),
                        children: [
                          TextSpan(
                            text:
                                single == null ? "" : single.data.noSuratJalan,
                            style: TextStyleL.primaryTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldCustom(
                      title: "Suhu",
                      controller: suhuController,
                      hintText: "Cth. 25",
                      titleTextStyle: TextStyleL.primaryTextStyle.copyWith(
                        color: ColorsL.primaryTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Foto"),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(style: BorderStyle.solid),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(path),
                            ElevatedButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ["jpg", "png", "bmp"],
                                );

                                if (result != null) {
                                  file = File(result.files.single.path!);
                                  String fileName = result.files.first.name;
                                  path = fileName;
                                } else {
                                  // User canceled the picker
                                }
                              },
                              child: const Text("Pilih File"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonPrimary(
                      title: "Update Data",
                      onTap: () {
                        if (file == null || suhuController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Silahkan Isi Semua data yang dibutuhkan")));
                        } else {
                          ProgressDialogCustom.showLoading(
                              context, NavKey.keyLoader);
                          trackingProvider
                              .updateData(file!, widget.id.toString(),
                                  suhuController.text)
                              .then((value) {
                            backScreen();
                            backScreen("reff");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Data Berhasil Di Update"),
                              ),
                            );
                          });
                        }
                      },
                      size: 40,
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
