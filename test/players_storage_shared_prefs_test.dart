import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squid_game_list/data/repositories/players_storage_shared_prefs.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group("PlayersStorageSharedPrefs", () {
    var mockedSharedPrefs = MockSharedPreferences();
    group("getEliminatedPlayersIds", () {
      test("returns non empty list of ints", () async {
        var storage = PlayersStorageSharedPrefs(mockedSharedPrefs);

        when(mockedSharedPrefs.getStringList(storage.playersStorageKey)).thenReturn(["23", "44", "55"]);

        var result = await storage.getEliminatedPlayersIds();

        expect(result, isA<List<int>>());
        expect(result, isNotEmpty);
      });

      test("returns empty list when no data from shared prefs obtained", () async {
        var storage = PlayersStorageSharedPrefs(mockedSharedPrefs);

        when(mockedSharedPrefs.getStringList(storage.playersStorageKey)).thenReturn(null);

        var result = await storage.getEliminatedPlayersIds();

        expect(result, isA<List<int>>());
        expect(result, isEmpty);
      });
    });
  });
}
