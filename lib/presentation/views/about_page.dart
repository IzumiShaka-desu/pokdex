import 'package:flutter/material.dart';
import 'package:pokdex/common/extension/context_utils.dart';
import 'package:pokdex/common/extension/extension.dart';

import '../../data/models/detail_pokemon.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    required this.data,
  });

  final DetailPokemon data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Habitat"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Height"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Weight"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Abilities"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        data.pokemonSpecies?.habitat.name.capitalized ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${data.height} Cm"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${data.weight} Kg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.abilities
                          .map((e) => e.ability.name.capitalized)
                          .join(", "),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8),
          child: Row(
            children: [
              Text(
                "Breeding",
                style: context.titleMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Growth rate"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Egg Groups"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${data.pokemonSpecies?.growthRate.name}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.pokemonSpecies?.eggGroups
                              .map((e) => e.name.capitalized)
                              .join(", ") ??
                          "",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
