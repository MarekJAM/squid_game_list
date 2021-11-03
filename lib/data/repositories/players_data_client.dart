import '../models/player.dart';

abstract class PlayersDataClient {
  Future<List<Player>> getPlayers();
}