import 'dart:convert';

PokemonSpecies pokemonSpeciesFromJson(String str) =>
    PokemonSpecies.fromJson(json.decode(str));

String pokemonSpeciesToJson(PokemonSpecies data) => json.encode(data.toJson());

class PokemonSpecies {
  final int baseHappiness;
  final int captureRate;
  final PokeCon color;
  final List<PokeCon> eggGroups;
  final String evolutionChain;

  final bool formsSwitchable;
  final int genderRate;
  final PokeCon growthRate;
  final PokeCon habitat;
  final bool hasGenderDifferences;
  final int hatchCounter;
  final int id;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final String name;
  final int order;
  final PokeCon shape;

  int get idEvo => int.parse(
      evolutionChain.split('/').where((element) => element.isNotEmpty).last);

  PokemonSpecies({
    required this.baseHappiness,
    required this.captureRate,
    required this.color,
    required this.eggGroups,
    required this.evolutionChain,
    required this.formsSwitchable,
    required this.genderRate,
    required this.growthRate,
    required this.habitat,
    required this.hasGenderDifferences,
    required this.hatchCounter,
    required this.id,
    required this.isBaby,
    required this.isLegendary,
    required this.isMythical,
    required this.name,
    required this.order,
    required this.shape,
  });

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
        baseHappiness: json["base_happiness"],
        captureRate: json["capture_rate"],
        color: PokeCon.fromJson(json["color"]),
        eggGroups: List<PokeCon>.from(
            json["egg_groups"].map((x) => PokeCon.fromJson(x))),
        evolutionChain: json["evolution_chain"]["url"],
        formsSwitchable: json["forms_switchable"],
        genderRate: json["gender_rate"],
        growthRate: PokeCon.fromJson(json["growth_rate"]),
        habitat: PokeCon.fromJson(json["habitat"]),
        hasGenderDifferences: json["has_gender_differences"],
        hatchCounter: json["hatch_counter"],
        id: json["id"],
        isBaby: json["is_baby"],
        isLegendary: json["is_legendary"],
        isMythical: json["is_mythical"],
        name: json["name"],
        order: json["order"],
        shape: PokeCon.fromJson(json["shape"]),
      );

  Map<String, dynamic> toJson() => {
        "base_happiness": baseHappiness,
        "capture_rate": captureRate,
        "color": color.toJson(),
        "egg_groups": List<dynamic>.from(eggGroups.map((x) => x.toJson())),
        "evolution_chain": {
          "url": evolutionChain,
        },
        "forms_switchable": formsSwitchable,
        "gender_rate": genderRate,
        "growth_rate": growthRate.toJson(),
        "habitat": habitat.toJson(),
        "has_gender_differences": hasGenderDifferences,
        "hatch_counter": hatchCounter,
        "id": id,
        "is_baby": isBaby,
        "is_legendary": isLegendary,
        "is_mythical": isMythical,
        "name": name,
        "order": order,
        "shape": shape.toJson(),
      };
}

class PokeCon {
  final String name;
  final String url;

  PokeCon({
    required this.name,
    required this.url,
  });

  factory PokeCon.fromJson(Map<String, dynamic> json) => PokeCon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
