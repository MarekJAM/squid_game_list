import 'package:flutter/material.dart';

import '../data/models/player.dart';

class DetailsScreen extends StatelessWidget {
  final Player player;

  const DetailsScreen({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
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
            ),
            ColumnTextItem(
              label: "Name",
              content: player.name,
            ),
            ColumnTextItem(
              label: "Description",
              content: player.description ?? "This player has no description.",
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
