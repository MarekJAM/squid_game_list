part of 'players_cubit.dart';

@immutable
abstract class PlayersState {}

class PlayersInitial extends PlayersState {}

class PlayersLoading extends PlayersState {}

class PlayersLoaded extends PlayersState {
  final List<Player> players;

  PlayersLoaded({required this.players});
}

class PlayersError extends PlayersState {
  final String message;

  PlayersError(this.message);
}