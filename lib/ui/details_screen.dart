import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/players/players_cubit.dart';
import '../data/models/player.dart';
import '../configurable/keys.dart';

class DetailsScreen extends StatelessWidget {
  final Player player;

  const DetailsScreen({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (!player.isEliminated)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                key: Keys.btnEliminate,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<PlayersCubit>(context).eliminatePlayer(player);
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.eliminatePlayer),
              ),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Opacity(
                      opacity: player.isEliminated ? 0.3 : 1,
                      child: player.pictureUrl != null
                          ? Image.network(
                              player.pictureUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey,
                                height: 300,
                              ),
                            )
                          : Container(
                              height: 300,
                              color: Colors.grey,
                            ),
                    ),
                    if (player.isEliminated)
                      Transform.rotate(
                        angle: math.pi / 6,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.eliminated,
                            style: const TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            ColumnTextItem(
              label: AppLocalizations.of(context)!.nameLabel,
              content: player.name,
            ),
            ColumnTextItem(
              label: AppLocalizations.of(context)!.descriptionLabel,
              content: player.description ?? AppLocalizations.of(context)!.noDescription,
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnTextItem extends StatelessWidget {
  final String label;
  final String content;

  const ColumnTextItem({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        readOnly: true,
        initialValue: content,
        minLines: 1,
        maxLines: 1000,
        decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
          contentPadding: const EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
