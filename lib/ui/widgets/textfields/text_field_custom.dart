import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/colors.dart';
import 'package:lobbying/const/styles/fonts.dart';

class TextFieldCustom extends StatefulWidget {
  final String? title;
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? titleTextStyle;
  TextFieldCustom({
    super.key,
    required this.title,
    required this.controller,
    this.contentPadding,
    this.hintText,
    this.hintTextStyle,
    this.titleTextStyle,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Text(
                widget.title!,
                style: widget.titleTextStyle ??
                    TextStyleL.primaryTextStyle.copyWith(
                        fontSize: 14,
                        color: ColorsL.primaryTextColor.withOpacity(0.5)),
              )
            : const SizedBox(),
        SizedBox(
          height: widget.title != null ? 8 : 0,
        ),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
            border: InputBorder.none,
            fillColor: ColorsL.aliceBlue,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: ColorsL.aliceBlue,
                width: 0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: ColorsL.aliceBlue,
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: ColorsL.aliceBlue, width: 0),
            ),
            hintText: widget.hintText == null ? "" : widget.hintText!,
            hintStyle: widget.hintTextStyle ??
                TextStyleL.primaryTextStyle.copyWith(
                  fontSize: 12,
                  color: ColorsL.primaryTextColor.withOpacity(
                    0.5,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
