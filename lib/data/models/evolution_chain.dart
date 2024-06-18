// To parse this JSON data, do
//
//     final evolutionChain = evolutionChainFromJson(jsonString);

import 'dart:convert';

import 'package:pokdex/data/models/pokemon.dart';

EvolutionChain evolutionChainFromJson(String str) =>
    EvolutionChain.fromJson(json.decode(str));

String evolutionChainToJson(EvolutionChain data) => json.encode(data.toJson());

class EvolutionChain {
  final Chain chain;
  final int id;

  EvolutionChain({
    required this.chain,
    required this.id,
  });

  factory EvolutionChain.fromJson(Map<String, dynamic> json) => EvolutionChain(
        chain: Chain.fromJson(json["chain"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "chain": chain.toJson(),
        "id": id,
      };
  EvolutionChain copyWith({
    Chain? chain,
    int? id,
  }) {
    return EvolutionChain(
      chain: chain ?? this.chain,
      id: id ?? this.id,
    );
  }

  List<Pokemon> get speciesList => chain.allSpecies();
}

class Chain {
  final List<Chain> evolvesTo;
  final bool isBaby;
  final Pokemon species;

  Chain({
    required this.evolvesTo,
    required this.isBaby,
    required this.species,
  });
  Chain copyWith({
    List<Chain>? evolvesTo,
    bool? isBaby,
    Pokemon? species,
  }) {
    return Chain(
      evolvesTo: evolvesTo ?? this.evolvesTo,
      isBaby: isBaby ?? this.isBaby,
      species: species ?? this.species,
    );
  }

  // Method untuk mengumpulkan semua spesies dibawah chain tertentu
  List<Pokemon> allSpecies({bool includeBaby = true}) {
    // Buat array `List<Pokemon>` untuk menyimpan semua spesies
    List<Pokemon> allSpecies = [];

    // Tambahkan spesies dari chain ini ke array `allSpecies`
    if (includeBaby || !isBaby) {
      allSpecies.add(species);
    }

    // Perulangan untuk menambahkan spesies dari chain turunan ke array `allSpecies`
    for (var chain in evolvesTo) {
      allSpecies.addAll(chain.allSpecies(includeBaby: includeBaby));
    }

    // Kembalikan array `allSpecies`
    return allSpecies;
  }

  factory Chain.fromJson(Map<String, dynamic> json) => Chain(
        evolvesTo:
            List<Chain>.from(json["evolves_to"].map((x) => Chain.fromJson(x))),
        isBaby: json["is_baby"],
        species: Pokemon.fromJson(json["species"]),
      );

  Map<String, dynamic> toJson() => {
        "evolves_to": List<dynamic>.from(evolvesTo.map((x) => x.toJson())),
        "is_baby": isBaby,
        "species": species.toJson(),
      };
}



// class Species {
//   final String name;
//   final String url;

//   Species({
//     required this.name,
//     required this.url,
//   });

//   factory Species.fromJson(Map<String, dynamic> json) => Species(
//         name: json["name"],
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "url": url,
//       };
// }
