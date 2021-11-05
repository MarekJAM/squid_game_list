import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import '../../data/repositories/players_repository.dart';
import '../../data/models/player.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  final PlayersRepository playersRepository;

  PlayersCubit({required this.playersRepository}) : super(PlayersInitial());

  void loadPlayers() async {
    emit(PlayersLoading());

    try {
      var players = await playersRepository.getPlayers();

      emit(PlayersLoaded(players: players));
    } catch (e) {
      debugPrint(e.toString());
      emit(PlayersError("Something went wrong."));
    }
  }

  void eliminatePlayer(Player player) async {
    if (state is PlayersLoaded) {
      var players = (state as PlayersLoaded).players;

      players.firstWhere((el) => el.id == player.id).isEliminated = true;

      await playersRepository.saveEliminatedPlayersIds(players.where((e) => e.isEliminated).map((e) => e.id).toList());

      emit(PlayersLoaded(players: (state as PlayersLoaded).players));
    }
  }

  void reset() async {
    if (state is PlayersLoaded) {
      for (var el in (state as PlayersLoaded).players) {
        el.isEliminated = false;
      }

      await playersRepository.clearEliminatedPlayersIds();

      emit(PlayersLoaded(players: (state as PlayersLoaded).players));
    }
  }
}
