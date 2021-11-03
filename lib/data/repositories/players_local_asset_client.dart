import 'dart:convert';

import 'package:flutter/services.dart';

import '../../configurable/asset_paths.dart';
import '../models/player.dart';
import 'players_data_client.dart';

class PlayersLocalAssetClient implements PlayersDataClient {
  @override
  Future<List<Player>> getPlayers() async {
    final String response = await rootBundle.loadString(AssetPaths.playersJson);
    final data = await json.decode(response);

    final players = <Player>[];

    data.forEach((el) => players.add(Player.fromJson(el)));

    return players;
  }
}
