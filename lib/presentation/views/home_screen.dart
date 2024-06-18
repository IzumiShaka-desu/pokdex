import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokdex/common/extension/context_utils.dart';
import 'package:pokdex/common/extension/extension.dart';
import 'package:pokdex/data/models/pokemon.dart';
import 'package:pokdex/presentation/viewmodels/main_viewmodel.dart';
import 'package:pokdex/presentation/widgets/loading_image.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                  right: -64,
                  top: -64,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/images/pokeball_grey.png",
                      width: 256,
                    ),
                  )),
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pokedex",
                          style: context.headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.format_list_bulleted_rounded),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final findState =
                              context.watch<MainViewmodel>().findState;
                          if (findState.isLoading) {
                            return const Center(
                              child: LoadingImage(
                                imagePath: "assets/images/pokeball_grey3.png",
                              ),
                            );
                          }
                          if (findState.isError) {
                            return Center(
                              child: Text(findState.errorMessage ?? ""),
                            );
                          }
                          if (findState.data == null ||
                              context.read<MainViewmodel>().image == null) {
                            // show welcome message
                            return const Center(
                              child: Text("Welcome to Pokedex"),
                            );
                          }

                          final candidates = findState.data!;
                          final image = context.read<MainViewmodel>().image;
                          String desc = "";
                          for (final item in candidates.content?.parts ?? []) {
                            desc += " ${item.text ?? ""}";
                          }
                          return FindCard(
                            description: desc.trim(),
                            image: image!,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          // select image and find button
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Builder(builder: (context) {
                  final image = context.watch<MainViewmodel>().image;
                  if (image != null) {
                    // show selected image file name with unselect button
                    String filename = image.path.split("/").last;
                    if (filename.length > 12) {
                      filename =
                          "${filename.substring(0, 12)}...${filename.substring(filename.length - 8, filename.length)}";
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          filename,
                          style: context.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<MainViewmodel>().image = null;
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    );
                  }
                  return InkWell(
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      try {
                        final image = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          // if mounted
                          if (context.mounted) {
                            context.read<MainViewmodel>().image =
                                File(image.path);
                          }
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Select Image",
                            style: context.titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            IconButton(
              onPressed: () {
                final image = context.read<MainViewmodel>().image;
                if (image != null) {
                  context.read<MainViewmodel>().findPokemon(image: image);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select an image first"),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}

class PokelistView extends StatelessWidget {
  const PokelistView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final listState = context.watch<MainViewmodel>().listState;
      if (listState.isLoading && listState.data == null) {
        return const Center(
          child: LoadingImage(imagePath: "assets/images/pokeball_grey3.png"),
        );
      }
      if (listState.isError && listState.data == null) {
        return Center(
          child: Text(listState.errorMessage ?? ""),
        );
      }
      final pokemons = listState.data ?? [];
      return GridView.builder(
        shrinkWrap: true,
        itemCount: pokemons.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          return PokeCard(pokemon: pokemon);
        },
      );
    });
  }
}

class FindCard extends StatelessWidget {
  const FindCard({
    super.key,
    required this.description,
    required this.image,
  });
  final String description;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            description.split(" ").first,
            style: context.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Image.file(
            image,
            width: 128,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: context.bodyMedium,
          ),

          // button see details
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              String name = description.split(" ").first.toLowerCase();
              if (name.isEmpty) return;
              context.push("/$name");
              context.read<MainViewmodel>().fetchDetailPokemon(id: name);
            },
            child: const Text("See Details"),
          ),
        ],
      ),
    );
  }
}

class PokeCard extends StatelessWidget {
  const PokeCard({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/${pokemon.id}");
        context
            .read<MainViewmodel>()
            .fetchDetailPokemon(id: pokemon.id.toString());
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
        decoration: BoxDecoration(
          color: pokemon.color.colorNameAsColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  pokemon.name,
                  style: context.titleLarge?.copyWith(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#${pokemon.id}",
                  style: context.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Image.network(
                    pokemon.imageUrl,
                    width: 64,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
