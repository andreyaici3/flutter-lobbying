import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lobbying/const/config.dart';
import 'package:lobbying/const/styles/fonts.dart';
import 'package:lobbying/ui/widgets/buttons/button_primary.dart';

class CardDataItem extends StatelessWidget {
  final String? nama;
  final String? surat;
  final String? nopol;
  final String? id;
  final String? suhu;
  final String? foto;
  final Function() onTap;
  final Function() onTap2;

  const CardDataItem({
    super.key,
    this.nama,
    this.suhu,
    this.surat,
    this.foto,
    this.id,
    this.nopol,
    required this.onTap,
    required this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Supir: ",
                      style: TextStyleL.primaryTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: nama ?? "Nama Supir",
                          style: TextStyleL.primaryTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "No Pol: ",
                      style: TextStyleL.primaryTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: nopol ?? "No Polisi",
                          style: TextStyleL.primaryTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(foto == null
                            ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                            : Config.getDirectory() + foto.toString()),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "No. Surat: ",
                          style: TextStyleL.primaryTextStyle
                              .copyWith(color: Colors.black, fontSize: 13),
                          children: [
                            TextSpan(
                              text: surat ?? "No Surat",
                              style: TextStyleL.primaryTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Nomor Register: ",
                          style: TextStyleL.primaryTextStyle
                              .copyWith(color: Colors.black, fontSize: 13),
                          children: [
                            TextSpan(
                              text: id ?? "Register",
                              style: TextStyleL.primaryTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Suhu: ",
                          style: TextStyleL.primaryTextStyle
                              .copyWith(color: Colors.black, fontSize: 13),
                          children: [
                            TextSpan(
                              text: suhu ?? "0",
                              style: TextStyleL.primaryTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ButtonPrimary(
                      size: 40,
                      title: "Update Data",
                      onTap: onTap,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: ButtonPrimary(
                      size: 40,
                      color: Colors.red,
                      title: "Hapus Data",
                      onTap: onTap2,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
