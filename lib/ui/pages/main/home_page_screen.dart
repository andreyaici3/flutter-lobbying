import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/colors.dart';
import 'package:lobbying/const/styles/fonts.dart';
import 'package:lobbying/data/commons/nav_key.dart';
import 'package:lobbying/data/commons/nav_utils.dart';
import 'package:lobbying/data/model/data_model.dart';
import 'package:lobbying/data/provider/tracking_provider.dart';
import 'package:lobbying/ui/pages/tracking/add_track_screen.dart';
import 'package:lobbying/ui/pages/tracking/update_track_screen.dart';
import 'package:lobbying/ui/widgets/buttons/button_primary.dart';
import 'package:lobbying/ui/widgets/cards/card_data_item.dart';
import 'package:lobbying/ui/widgets/dialog/confirmation_dialog.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  DataModel? dataModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final trackingProvider =
        Provider.of<TrackingProvider>(context, listen: false);
    trackingProvider.getData().then((value) {
      dataModel = value;
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: size.height * 0.23,
                decoration: const BoxDecoration(
                  color: ColorsL.primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png"))),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Halo",
                                    style: TextStyleL.primaryTextStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: trackingProvider.getNama(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("nama");
                                      } else {
                                        return Text(
                                          snapshot.data.toString(),
                                          style: TextStyleL.primaryTextStyle
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    ButtonPrimary(
                      title: "Tambah Data",
                      color: ColorsL.crimson,
                      onTap: () async {
                        final refresh =
                            await nextScreen(const AddTrackScreen());
                        if (refresh == "reff") {
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "List Data",
                      style: TextStyleL.primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<TrackingProvider>(
                      builder: (context, value, child) {
                        if (value.data != null) {
                          if (value.data!.data.isEmpty) {
                            return const Center(
                              child: Text("Tidak Ada Data"),
                            );
                          } else {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.data?.data.length,
                              itemBuilder: (context, index) {
                                return CardDataItem(
                                  nama: value.data?.data[index].driver,
                                  nopol: value.data?.data[index].noPol,
                                  id: value.data?.data[index].id.toString(),
                                  surat: value.data?.data[index].noSuratJalan,
                                  suhu: value.data?.data[index].suhu.toString(),
                                  foto: value.data!.data[index].foto,
                                  onTap: () async {
                                    final refresh =
                                        await nextScreen(UpdateTrackScreen(
                                      id: value.data!.data[index].id,
                                      suhu: value.data!.data[index].suhu,
                                    ));
                                    if (refresh == "reff") {
                                      setState(() {});
                                    }
                                  },
                                  onTap2: () async {
                                    await ConfirmationDialog.show(
                                      context,
                                      NavKey.keyLoader,
                                      value.data!.data[index].id.toString(),
                                    );
                                    await Future.delayed(
                                        const Duration(seconds: 2), () {
                                      setState(() {});
                                    });
                                  },
                                );
                              },
                            );
                          }
                        } else {
                          return const Center(
                            child: Text("Tidak Ada Data"),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
