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
}
