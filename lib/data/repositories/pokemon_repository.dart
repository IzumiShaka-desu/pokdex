import 'dart:io';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:pokdex/common/utils/exception.dart';
import 'package:pokdex/common/utils/type_definition.dart';
import 'package:pokdex/data/datasources/gemini_service.dart';

import '../datasources/pokemon_datasources.dart';

class PokemonRepository {
  PokemonRepository._internal();
  static final _singleton = PokemonRepository._internal();
  factory PokemonRepository() => _singleton;
  final _datasources = PokemonDatasources();
  final _geminiService = GeminiService();
  Future<PokemonsOrFailure> fetchPokemonList({int? offset = 0}) =>
      tryCatch(() async {
        final response = await _datasources.fetchPokemonList(offset: offset);
        return response.results;
      });
  Future<DetailPokemonOrFailure> fetchDetailPokemon({required String id}) =>
      tryCatch(() async {
        final response = await _datasources.fetchDetailPokemon(id: id);
        return response;
      });

  Future<FailOr<Candidates>> findPokemon({required File image}) async =>
      tryCatch(() async {
        final response = await _geminiService.findPokemon(image: image);
        return response;
      });
}
