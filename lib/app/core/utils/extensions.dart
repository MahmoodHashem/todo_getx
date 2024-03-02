
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSize on double{
  double get responsiveHeight => (Get.height * (this/100));
  double get responsiveWeight => (Get.width * (this/100));
}

extension ResponsiveText on double {
  double get responsiveFont => Get.width / 100 * (this/3);
}

extension HexColor on Color{
  static Color fromHex(String hexString){
    String cleanedHex = hexString.toUpperCase().replaceAll("#", "");

    if (cleanedHex.length == 6) {
      cleanedHex = "0xFF" + cleanedHex; // Adding alpha value if it's not present
    }
    return Color(int.parse(cleanedHex, radix: 16));
  }

  String toHex() {
    String hexAlpha = (this.alpha & 0xff).toRadixString(16).padLeft(2, '0');
    String hexRed = (this.red & 0xff).toRadixString(16).padLeft(2, '0');
    String hexGreen = (this.green & 0xff).toRadixString(16).padLeft(2, '0');
    String hexBlue = (this.blue & 0xff).toRadixString(16).padLeft(2, '0');

    return '#$hexAlpha$hexRed$hexGreen$hexBlue';
  }

}




