import '../models/player.dart';
import 'players_data_client.dart';
import 'players_storage.dart';

class PlayersRepository {
  final PlayersDataClient playersDataClient;
  final PlayersStorage playersStorage;

  PlayersRepository({required this.playersDataClient, required this.playersStorage});

  Future<List<Player>> getPlayers() async {
    var eliminatedIds = await playersStorage.getEliminatedPlayersIds();
    var players = await playersDataClient.getPlayers();
    for (var id in eliminatedIds) {
      players.firstWhere((el) => el.id == id).isEliminated = true;
    }
    return players;
  }

  Future<void> saveEliminatedPlayersIds(List<int> ids) async {
    return await playersStorage.saveEliminatedPlayersIds(ids);
  }

  Future<void> clearEliminatedPlayersIds() async {
    return await playersStorage.clearEliminatedPlayersIds();
  }
}
