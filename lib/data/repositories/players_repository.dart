import '../models/player.dart';
import 'players_data_client.dart';

class PlayersRepository {
  final PlayersDataClient playersDataClient;

  PlayersRepository({required this.playersDataClient});

  Future<List<Player>> getPlayers() async {
    return await playersDataClient.getPlayers();
  }
}