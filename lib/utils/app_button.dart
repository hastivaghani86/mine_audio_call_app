import 'package:flutter/material.dart';

import 'app_color.dart';

// ignore: must_be_immutable
class AppButton extends StatefulWidget {
  final String btnText;
  Function? onTap;
  Color? btnTxtColor;
  Color? bgColor;
  double? width;
  double? height;

  AppButton(
      {Key? key,
      required this.btnText,
      this.onTap,
      this.btnTxtColor,
      this.width,
      this.height,
      this.bgColor})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.bgColor ?? AppColor.primaryColor,
            borderRadius: BorderRadius.circular(16)),
        height: 48,
        width: widget.width ?? double.infinity,
        child: Center(
          child: FittedBox(
            child: Text(
              widget.btnText,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
