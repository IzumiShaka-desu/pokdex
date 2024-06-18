import 'package:pokdex/data/datasources/base_client.dart';
import 'package:pokdex/data/models/detail_pokemon.dart';
import 'package:pokdex/data/models/evolution_chain.dart';
import 'package:pokdex/data/models/poke_list.dart';
import 'package:pokdex/data/models/pokemon.dart';

import '../models/pokemon_species.dart';

class PokemonDatasources extends BaseClient {
  PokemonDatasources._internal();
  static final _singleton = PokemonDatasources._internal();
  factory PokemonDatasources() => _singleton;

  Future<PokeList> fetchPokemonList({int? offset = 0}) => tryRequest(() async {
        final response = await get("/pokemon", queryParameters: {
          "offset": offset,
          "limit": 20,
        });
        final pokeList = PokeList.fromJson(response.data);
        return pokeList.copyWith(
          results: await Future.wait<Pokemon>(pokeList.results.map((e) async {
            final species = await fetchSpecies(id: e.id);
            return e.copyWith(
              color: species.color.name,
            );
          }).toList()),
        );
      });
  Future<DetailPokemon> fetchDetailPokemon({required String id}) =>
      tryRequest(() async {
        final response = await get("/pokemon/$id");
        final pokemon = DetailPokemon.fromJson(response.data);
        final species = await fetchSpecies(id: pokemon.idSpecies);

        return pokemon.copyWith(
          pokemonSpecies: species,
          evolutionChain: await fetchEvolutionChain(id: species.idEvo),
        );
      });
  Future<PokemonSpecies> fetchSpecies({required String id}) =>
      tryRequest(() async {
        final response = await get("/pokemon-species/$id");
        final species = PokemonSpecies.fromJson(response.data);
        return species;
      });
  Future<List<Pokemon>> fetchEvolutionChain({required int id}) =>
      tryRequest(() async {
        final response = await get("/evolution-chain/$id");
        final evolutionChain = EvolutionChain.fromJson(response.data);

        return await Future.wait<Pokemon>(evolutionChain.speciesList
            .map((e) => e.fetchColorScheme())
            .toList());
      });
}
