import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/colors.dart';
import 'package:lobbying/const/styles/fonts.dart';

class PasswordFieldCustom extends StatefulWidget {
  final String? title;
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final bool passwordMode;

  const PasswordFieldCustom({
    super.key,
    required this.title,
    required this.controller,
    this.contentPadding,
    this.hintText,
    this.passwordMode = true,
    this.hintTextStyle,
  });

  @override
  State<PasswordFieldCustom> createState() => _PasswordFieldCustomState();
}

class _PasswordFieldCustomState extends State<PasswordFieldCustom> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Text(
                widget.title!,
                style: TextStyleL.primaryTextStyle.copyWith(
                    fontSize: 14,
                    color: ColorsL.primaryTextColor.withOpacity(0.5)),
              )
            : const SizedBox(),
        SizedBox(
          height: widget.title != null ? 8 : 0,
        ),
        TextField(
          controller: widget.controller,
          obscureText: _visible,
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
            suffixIcon: widget.passwordMode
                ? IconButton(
                    icon: Icon(
                      _visible
                          ? Icons.visibility_off
                          : Icons
                              .visibility, //change icon based on boolean value
                      color: ColorsL.primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible; //change boolean value
                      });
                    },
                  )
                : const SizedBox(),
            errorStyle: const TextStyle(
              fontSize: 10.0,
            ),
            errorMaxLines: 4,
          ),
        ),
      ],
    );
  }
}
