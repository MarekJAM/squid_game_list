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
      List<int> eliminatedIds = [];

      for (var el in players) {
        if (el.id == player.id) {
          el.isEliminated = true;
        }

        if (el.isEliminated) {
          eliminatedIds.add(el.id);
        }
      }

      await playersRepository.saveEliminatedPlayersIds(eliminatedIds);

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
