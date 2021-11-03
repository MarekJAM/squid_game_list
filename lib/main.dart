import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blocs.dart';
import 'data/repositories/repositories.dart';
import 'ui/main_screen.dart';

void main() {
  if (kDebugMode) {
    Bloc.observer = SimpleBlocObserver();
  }

  final playersRepository = PlayersRepository(playersDataClient: PlayersLocalAssetClient());

  runApp(App(
    playersRepository: playersRepository,
  ));
}

class App extends StatelessWidget {
  final PlayersRepository playersRepository;

  const App({Key? key, required this.playersRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squid Game List',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: BlocProvider<PlayersCubit>(
        create: (context) => PlayersCubit(playersRepository: playersRepository)..loadPlayers(),
        child: const MainScreen(),
      ),
    );
  }
}

