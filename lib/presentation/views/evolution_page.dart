import 'package:flutter/material.dart';
import 'package:pokdex/common/extension/context_utils.dart';
import 'package:pokdex/common/extension/extension.dart';

import '../../data/models/detail_pokemon.dart';
import '../../data/models/pokemon.dart';

class EvolutionPage extends StatelessWidget {
  const EvolutionPage({
    super.key,
    required this.data,
  });

  final DetailPokemon data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8),
          child: Row(
            children: [
              Text(
                "Evolution",
                style: context.titleMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...evolutionPair
            .map((e) => Row(
                  children: [
                    ...e
                        .map<Widget>((e) => Expanded(
                              child: Column(
                                children: [
                                  Image.network(
                                    e.imageUrl,
                                    width: 100,
                                  ),
                                  Text(e.name.capitalized),
                                ],
                              ),
                            ))
                        .toList()
                      ..insert(
                          1,
                          const Column(
                            children: [
                              Icon(Icons.chevron_right_outlined),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Evolved")
                            ],
                          )),
                  ],
                ))
            ,
      ],
    );
  }

  List<List<Pokemon>> get evolutionPair {
    // it will return list of list of pokemon that will be grouped by 2 that is before evo and after eo
    final result = <List<Pokemon>>[];
    for (var i = 0; i < data.evolutionChain.length; i++) {
      if (i + 1 < data.evolutionChain.length) {
        result.add([data.evolutionChain[i], data.evolutionChain[i + 1]]);
      }
    }

    return result;
  }
}
