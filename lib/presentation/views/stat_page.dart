import 'package:flutter/material.dart';
import 'package:pokdex/common/extension/extension.dart';

import '../../data/models/detail_pokemon.dart';

class StatPage extends StatelessWidget {
  const StatPage({
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.stats
                    .map((e) => e.stat.name.capitalized)
                    .toList()
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: Text(e),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.stats
                    .map((e) => e.baseStat)
                    .toList()
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(e.toString()),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: e / 100,
                                  color: (e / 100) < 0.5
                                      ? "red".colorNameAsColor
                                      : (e / 100) < 0.8
                                          ? "green".colorNameAsColor
                                          : "blue".colorNameAsColor,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
