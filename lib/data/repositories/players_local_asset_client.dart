import 'dart:convert';

import 'package:flutter/services.dart';

import '../../configurable/asset_paths.dart';
import '../models/player.dart';
import 'players_data_client.dart';

class PlayersLocalAssetClient implements PlayersDataClient {
  late AssetBundle _bundle;

  PlayersLocalAssetClient({AssetBundle? bundle}) {
    _bundle = bundle ?? rootBundle;
  }

  @override
  Future<List<Player>> getPlayers({String assetPath = AssetPaths.playersJson}) async {
    final String response = await _bundle.loadString(assetPath);
    final data = await json.decode(response);

    final players = <Player>[];

    data.forEach((el) => players.add(Player.fromJson(el)));

    return players;
  }
}
