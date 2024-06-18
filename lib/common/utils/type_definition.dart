import 'package:dartz/dartz.dart';
import 'package:pokdex/data/models/detail_pokemon.dart';

import '../../data/models/pokemon.dart';
import 'failure.dart';

bool xor(bool a, bool b) => (a || b) && !(a && b);

typedef PokemonsOrFailure = Either<Failure, List<Pokemon>>;
typedef DetailPokemonOrFailure = Either<Failure, DetailPokemon>;
typedef FailOr<T> = Either<Failure, T>;
