import 'package:shared_preferences/shared_preferences.dart';

import 'players_storage.dart';

class PlayersStorageSharedPrefs implements PlayersStorage {
  final SharedPreferences prefs;

  const PlayersStorageSharedPrefs(this.prefs);

  final playersStorageKey = "players";

  @override
  Future<List<int>> getEliminatedPlayersIds() async {
    var stringList = prefs.getStringList(playersStorageKey) ?? [];
    return stringList.map((e) => int.parse(e)).toList();
  }

  @override
  Future<bool> saveEliminatedPlayersIds(List<int> ids) async {
    return await prefs.setStringList(playersStorageKey, ids.map((e) => e.toString()).toList());
  }

  @override
  Future<bool> clearEliminatedPlayersIds() async {
    return await prefs.remove(playersStorageKey);
  }
}
