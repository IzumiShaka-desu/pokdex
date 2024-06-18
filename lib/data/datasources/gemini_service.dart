import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  final Gemini client = Gemini.instance;
  GeminiService();

  Future<Candidates> findPokemon({
    required File image,
  }) async {
    final response = await client.textAndImage(
      text:
          "if this image doesn't contain any single pokemon give response \"pokemon not found\", if any pokemon give short description about one pokemon in this picture start with name of selected pokemon",
      images: [
        image.readAsBytesSync(),
      ],
    );
    if (response != null) {
      return response;
    }
    throw Exception("Failed to find pokemon");
  }
}
