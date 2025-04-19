import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../app_managers/color_manager.dart';

class CustomBottom extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final double? padding;
  final double? radius;
  final IconData? icons;
  final double? iconPaddingLeft;
  final Color? iconColor;
  final Color? borderColor;
  final double? borderWidth;
  final FontWeight? fontWeight;

  final List<BoxShadow>? boxShadow;
  const CustomBottom({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
    this.padding,
    this.radius,
    this.icons,
    this.iconColor,
    this.iconPaddingLeft,
    this.boxShadow,
    this.fontWeight,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: boxShadow,
          border: Border.all(
              color: borderColor ?? Colors.white, width: borderWidth ?? 0),
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))),
      padding: EdgeInsets.symmetric(vertical: padding ?? 16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icons,
            color: iconColor,
          ),
          SizedBox(
            width: iconPaddingLeft,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            // style: GoogleFonts.inter(
            //     fontSize: fontSize ?? 16,
            //     fontWeight: fontWeight ?? FontWeight.w700,
            //     color: textColor ?? ColorManager.bodyB1)
          ),
        ],
      ),
    );
  }
}

class CustomAssetBottom extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final double? padding;
  final double? radius;
  final String iconsAsset;
  final double? iconPaddingLeft;
  final Color? iconColor;

  final List<BoxShadow>? boxShadow;
  const CustomAssetBottom(
      {Key? key,
      required this.text,
      this.textColor,
      this.backgroundColor,
      this.fontSize,
      this.padding,
      this.radius,
      required this.iconsAsset,
      this.iconColor,
      this.iconPaddingLeft,
      this.boxShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))),
      padding: EdgeInsets.symmetric(vertical: padding ?? 16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconsAsset),
          SizedBox(
            width: iconPaddingLeft,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            // style: GoogleFonts.inter(
            //     fontSize: fontSize ?? 16,
            //     fontWeight: FontWeight.w700,
            //     color: textColor ?? ColorManager.bodyB1)
          ),
        ],
      ),
    );
  }
}
