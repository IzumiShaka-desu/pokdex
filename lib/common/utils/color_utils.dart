import 'package:flutter/material.dart';

Color fromHex(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

Future<ColorScheme> getColorFromImageNetwork(String url) async {
  // Buat objek `ImageInfo` dari gambar.
  // final imageInfo = image.image;
  final scheme =
      await ColorScheme.fromImageProvider(provider: NetworkImage(url));
  return scheme;
}
