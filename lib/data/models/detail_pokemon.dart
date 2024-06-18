import 'dart:convert';

import 'package:pokdex/common/app_config.dart';
import 'package:pokdex/data/models/pokemon.dart';
import 'package:pokdex/data/models/pokemon_species.dart';

DetailPokemon detailPokemonFromJson(String str) =>
    DetailPokemon.fromJson(json.decode(str));

String detailPokemonToJson(DetailPokemon data) => json.encode(data.toJson());

class DetailPokemon {
  final List<Ability> abilities;
  final int baseExperience;
  final List<Species> forms;
  final int height;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final String name;
  final int order;
  final Species species;
  final List<Stat> stats;
  final List<Type> types;
  final List<Pokemon> evolutionChain;
  final PokemonSpecies? pokemonSpecies;
  final int weight;
  String get idEvolution =>
      species.url.split('/').where((element) => element.isNotEmpty).last;
  String get idSpecies =>
      species.url.split('/').where((element) => element.isNotEmpty).last;
  String get imageUrl => "${AppConfig.baseUrlPngImages}$id.png";
  String get gifUrl => "${AppConfig.baseUrlGifImages}$id.gif";
  String get svgUrl => "${AppConfig.baseUrlSvgImages}$id.svg";

  DetailPokemon({
    required this.abilities,
    required this.baseExperience,
    required this.forms,
    required this.height,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.species,
    required this.stats,
    required this.types,
    required this.weight,
    this.evolutionChain = const [],
    this.pokemonSpecies,
  });
  DetailPokemon copyWith(
      {List<Ability>? abilities,
      int? baseExperience,
      List<Species>? forms,
      int? height,
      int? id,
      bool? isDefault,
      String? locationAreaEncounters,
      List<Move>? moves,
      String? name,
      int? order,
      Species? species,
      List<Stat>? stats,
      List<Type>? types,
      int? weight,
      List<Pokemon>? evolutionChain,
      PokemonSpecies? pokemonSpecies}) {
    return DetailPokemon(
      abilities: abilities ?? this.abilities,
      baseExperience: baseExperience ?? this.baseExperience,
      forms: forms ?? this.forms,
      height: height ?? this.height,
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
      locationAreaEncounters:
          locationAreaEncounters ?? this.locationAreaEncounters,
      moves: moves ?? this.moves,
      name: name ?? this.name,
      order: order ?? this.order,
      species: species ?? this.species,
      stats: stats ?? this.stats,
      types: types ?? this.types,
      weight: weight ?? this.weight,
      evolutionChain: evolutionChain ?? this.evolutionChain,
      pokemonSpecies: pokemonSpecies ?? this.pokemonSpecies,
    );
  }

  factory DetailPokemon.fromJson(Map<String, dynamic> json) => DetailPokemon(
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        baseExperience: json["base_experience"],
        forms:
            List<Species>.from(json["forms"].map((x) => Species.fromJson(x))),
        height: json["height"],
        id: json["id"],
        isDefault: json["is_default"],
        locationAreaEncounters: json["location_area_encounters"],
        moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        name: json["name"],
        order: json["order"],
        species: Species.fromJson(json["species"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "base_experience": baseExperience,
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
        "height": height,
        "is_default": isDefault,
        "location_area_encounters": locationAreaEncounters,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name,
        "order": order,
        "species": species.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "weight": weight,
      };
}

class Ability {
  final Species ability;
  final bool isHidden;
  final int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: Species.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Move {
  final Species move;
  final List<VersionGroupDetail> versionGroupDetails;

  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        move: Species.fromJson(json["move"]),
        versionGroupDetails: List<VersionGroupDetail>.from(
            json["version_group_details"]
                .map((x) => VersionGroupDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "move": move.toJson(),
        "version_group_details":
            List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
      };
}

class VersionGroupDetail {
  final int levelLearnedAt;
  final Species moveLearnMethod;
  final Species versionGroup;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) =>
      VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        moveLearnMethod: Species.fromJson(json["move_learn_method"]),
        versionGroup: Species.fromJson(json["version_group"]),
      );

  Map<String, dynamic> toJson() => {
        "level_learned_at": levelLearnedAt,
        "move_learn_method": moveLearnMethod.toJson(),
        "version_group": versionGroup.toJson(),
      };
}

class Stat {
  final int baseStat;
  final int effort;
  final Species stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

class Type {
  final int slot;
  final Species type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}
