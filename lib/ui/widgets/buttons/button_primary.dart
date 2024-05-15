import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/colors.dart';
import 'package:lobbying/const/styles/fonts.dart';

class ButtonPrimary extends StatelessWidget {
  final double? size;
  final EdgeInsets? margin;
  final Function() onTap;
  final Color? color;
  final String title;
  final bool enabled;
  final bool isLoading;
  const ButtonPrimary({
    super.key,
    required this.title,
    required this.onTap,
    this.size,
    this.margin,
    this.enabled = true,
    this.isLoading = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 50,
      decoration: BoxDecoration(
        color: color ?? ColorsL.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: () {
          if (enabled) onTap();
        },
        child: isLoading
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style: TextStyleL.primaryTextStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
