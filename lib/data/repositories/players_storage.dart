abstract class PlayersStorage {
  Future<List<int>> getEliminatedPlayersIds();

  Future saveEliminatedPlayersIds(List<int> ids);

  Future clearEliminatedPlayersIds();
}