import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'details_screen.dart';
import '../bloc/blocs.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PlayersCubit, PlayersState>(
          builder: (context, state) {
            if (state is PlayersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PlayersLoaded) {
              if (state.players.isEmpty) {
                return const Center(
                  child: Text('Players list is empty.'),
                );
              }
              return ListView.builder(
                itemCount: state.players.length,
                itemBuilder: (context, index) {
                  var player = state.players[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => DetailsScreen(
                            player: player,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: player.pictureUrl != null
                                ? Image.network(
                                    player.pictureUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.grey,
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        title: Text(
                          player.name,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Could not get list of players."),
                  OutlinedButton(
                    onPressed: () {
                      BlocProvider.of<PlayersCubit>(context).loadPlayers();
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
