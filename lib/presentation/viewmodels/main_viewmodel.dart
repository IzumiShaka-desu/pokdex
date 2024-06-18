import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:pokdex/common/enum/screen_status.dart';
import 'package:pokdex/common/utils/app_state.dart';
import 'package:pokdex/data/models/detail_pokemon.dart';
import 'package:pokdex/data/models/pokemon.dart';
import 'package:pokdex/data/repositories/pokemon_repository.dart';

class MainViewmodel extends ChangeNotifier {
  MainViewmodel._internal();
  static final _singleton = MainViewmodel._internal();
  factory MainViewmodel() => _singleton;
  final _repository = PokemonRepository();
  AppState<List<Pokemon>> _listState = AppState();
  AppState<List<Pokemon>> get listState => _listState;
  Future<void> fetchPokemonList({int? offset = 0}) async {
    _listState = _listState.copyWith(screenState: ScreenStatus.loading);
    notifyListeners();
    final response = await _repository.fetchPokemonList(offset: offset);
    response.fold((failure) {
      _listState = _listState.copyWith(
        screenState: ScreenStatus.error,
        errorMessage: failure.message,
      );
      notifyListeners();
    }, (data) {
      _listState = _listState.copyWith(
          screenState: ScreenStatus.success,
          data: (_listState.data ?? [])..addAll(data),
          errorMessage: null);
      notifyListeners();
    });
  }

  AppState<DetailPokemon> _appState = AppState();
  AppState<DetailPokemon> get appState => _appState;

  Future<void> fetchDetailPokemon({required String id}) async {
    _appState = _appState.copyWith(screenState: ScreenStatus.loading);
    notifyListeners();
    final response = await _repository.fetchDetailPokemon(id: id);
    response.fold(
      (failure) {
        _appState = _appState.copyWith(
          screenState: ScreenStatus.error,
          errorMessage: failure.message,
        );
        notifyListeners();
      },
      (data) {
        _appState = _appState.copyWith(
            screenState: ScreenStatus.success, data: data, errorMessage: null);
        notifyListeners();
      },
    );
  }

  File? _image;
  File? get image => _image;
  set image(File? value) {
    _image = value;
    notifyListeners();
  }

  AppState<Candidates> _findState = AppState<Candidates>();
  AppState<Candidates> get findState => _findState;

  void findPokemon({required File image}) async {
    if (_findState.isLoading) return;
    _findState = _findState.copyWith(screenState: ScreenStatus.loading);
    notifyListeners();
    final response = await _repository.findPokemon(image: image);
    response.fold((failure) {
      _findState = _findState.copyWith(
        screenState: ScreenStatus.error,
        errorMessage: failure.message,
      );
    }, (data) {
      _findState = _findState.copyWith(
        screenState: ScreenStatus.success,
        data: data,
        errorMessage: null,
      );
    });
    notifyListeners();
  }
}
