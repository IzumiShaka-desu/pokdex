import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokdex/common/extension/context_utils.dart';
import 'package:pokdex/common/extension/extension.dart';
import 'package:pokdex/data/models/detail_pokemon.dart';
import 'package:pokdex/presentation/viewmodels/main_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/loading_image.dart';
import 'about_page.dart';
import 'evolution_page.dart';
import 'stat_page.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required id});

  @override
  Widget build(BuildContext context) {
    // draggableScrollableSheetController = DraggableScrollableActuator.of(context);
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          final appState = context.watch<MainViewmodel>().appState;
          if (appState.isLoading) {
            return const Center(
              child:
                  LoadingImage(imagePath: "assets/images/pokeball_grey3.png"),
            );
          }
          if (appState.isError) {
            return Center(
              child: Text(appState.errorMessage ?? ""),
            );
          }
          final data = appState.data!;
          return Stack(
            fit: StackFit.loose,
            children: [
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
                  decoration: BoxDecoration(
                    color: data.pokemonSpecies?.color.name.colorNameAsColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            icon: const Icon(Icons.favorite_border),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name.capitalized,
                                  style: context.headlineLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: data.types
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                              decoration: BoxDecoration(
                                                color: Colors.white30,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Text(
                                                e.type.name.capitalized,
                                                style: context.bodyMedium
                                                    ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )
                              ],
                            ),
                            Text(
                              "#${fillStringWith(data.id.toString())}",
                              style: context.headlineLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/images/pokeball.png",
                            width: 150,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.58,
                  maxChildSize: 1,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          SizedBox(
                            child: Stack(
                              children: [
                                DetailBody(data: data),
                                Transform.translate(
                                  offset: const Offset(0, -128),
                                  child: Center(
                                    child: Image.network(
                                      data.imageUrl,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class DetailBody extends StatefulWidget {
  const DetailBody({
    super.key,
    required this.data,
  });

  final DetailPokemon data;

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  tabs: ["About", "Base Stat", "Evolution", "Moves"]
                      .map((e) => Tab(text: e))
                      .toList(),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
            child: AnimatedBuilder(
                animation: _tabController,
                builder: (context, _) {
                  switch (_tabController.index) {
                    case 0:
                      return AboutPage(data: widget.data);
                    case 1:
                      return StatPage(data: widget.data);
                    case 2:
                      return EvolutionPage(data: widget.data);
                    case 3:
                      return MovesPage(data: widget.data);
                    default:
                      return Container();
                  }
                }),
          )
        ],
      ),
    );
  }
}

class MovesPage extends StatelessWidget {
  const MovesPage({
    super.key,
    required this.data,
  });

  final DetailPokemon data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: buildBodies(context),
    );
  }

  List<List<String>> get movements {
    // group moves to 4 group
    final int itemCount = data.moves.length;

    final movements = List.generate(4, (index) => <String>[]);
    for (int i = 0; i < itemCount; i++) {
      // Tentukan list mana yang akan menyimpan item
      final int listIndex = i % 4;

      // Tambahkan item ke list
      movements[listIndex].add(data.moves[i].move.name);
    }

    return movements;
  }

  List<Widget> buildBodies(BuildContext context) {
    final bodies = <Widget>[];
    movements.asMap().forEach((index, e) {
      bodies.add(
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Movements ${index + 1}",
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: e
                    .map((move) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(move.capitalized),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    });
    return bodies;
  }
}
