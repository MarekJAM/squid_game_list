import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/blocs.dart';
import 'data/repositories/repositories.dart';
import 'ui/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    Bloc.observer = SimpleBlocObserver();
  }

  var prefs = await SharedPreferences.getInstance();

  final playersRepository = PlayersRepository(
    playersDataClient: PlayersLocalAssetClient(),
    playersStorage: PlayersStorageSharedPrefs(prefs),
  );

  runApp(App(
    playersRepository: playersRepository,
  ));
}

class App extends StatelessWidget {
  final PlayersRepository playersRepository;

  const App({Key? key, required this.playersRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayersCubit>(
      create: (context) => PlayersCubit(playersRepository: playersRepository)..loadPlayers(),
      child: MaterialApp(
        title: 'Squid Game List',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
