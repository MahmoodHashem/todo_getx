
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
      cleanedHex = "FF" + cleanedHex; // Adding alpha value if it's not present
    }
    return Color(int.parse(cleanedHex, radix: 16));
  }

  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}';

}




