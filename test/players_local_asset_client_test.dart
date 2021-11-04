import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:squid_game_list/data/repositories/players_local_asset_client.dart';

class MockAssetBundle extends Mock implements AssetBundle {
  @override
  Future<String> loadString(String? key, {bool? cache = false}) =>
      (super.noSuchMethod(Invocation.method(#loadString, [key], {#cache: cache}), returnValue: Future<String>.value(''))
          as Future<String>);
}

void main() {
  group("PlayersLocalAssetClient", () {
    group("load players from json", () {
      test('returns non-empty list of players', () async {
        var assetBundle = MockAssetBundle();

        final client = PlayersLocalAssetClient(bundle: assetBundle);

        var mockedJsonString = ("""[{"id": "456",
        "name": "test name",
        "pict": "https://testurl.com",
        "description": "test description"}]""");

        when(assetBundle.loadString("")).thenAnswer((_) async => Future.value(mockedJsonString));

        var list = await client.getPlayers(assetPath: "");

        expect(list, isNotEmpty);
      });
    });
  });
}
