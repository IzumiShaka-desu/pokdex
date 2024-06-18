import 'dart:ui';

import 'package:pokdex/common/utils/color_utils.dart';

extension StringExtension on String {
  bool get isCodeValid {
    // example of code : 2212T00252K-AMB2311-10329
    // example of code : 2212T00269K-AMB2311-07693
    // using regex to validate squence of code with minium length is 15
    // and 2 chars at first is digit of year and next 2 chars is digit of month
    // and contains one K- and next of K- is 3 chars is capital letter

    RegExp regExp = RegExp(r"^\d{2}\d{2}T\d{5}K-[A-Z]{3}\d{4}");

    return regExp.hasMatch(trim());
  }

  String get capitalized {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  Color get colorNameAsColor {
    switch (this) {
      case "black":
        return fromHex("#705746");
      case "blue":
        return fromHex("#76BDFE");
      case "brown":
        return fromHex("#B6A136");
      case "gray":
        return fromHex("#B7B7CE");
      case "green":
        return fromHex("#48D0B0");
      case "pink":
        return fromHex("#D685AD");
      case "purple":
        return fromHex("#A33EA1");
      case "red":
        return fromHex("#FB6C6C");
      case "white":
        return fromHex("#A8A77A");
      case "yellow":
        return fromHex("#FFD86F");
      default:
        return fromHex("#A8A77A");
    }
  }
}

String fillStringWith(String string,
    {String fillString = "0", int maxLength = 3}) {
  if (string.length >= maxLength) return string;
  final diff = maxLength - string.length;
  return "${fillString * diff}$string";
}
