import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:squid_game_list/configurable/keys.dart';

import 'package:squid_game_list/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on second player, eliminate it and check if is greyed-out on the list',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final listViewFinder = find.byKey(Keys.listPlayers);
      final listItem = listViewFinder.evaluate().isEmpty
          ? null
          : find.descendant(of: listViewFinder, matching: find.byType(Text)).evaluate().elementAt(1).widget as Text;

      if (listItem == null) {
        fail('List not found');
      }

      await tester.tap(find.byWidget(listItem));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.btnEliminate));

      await tester.pumpAndSettle();
      
      expect((tester.widget(find.text(listItem.data!)) as Text).style!.color, Colors.grey);
    });
  });
}
