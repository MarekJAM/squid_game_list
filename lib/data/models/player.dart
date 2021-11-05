class Player {
  final int id;
  final String name;
  final String? description;
  final String? pictureUrl;
  bool isEliminated;

  Player({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureUrl,
    this.isEliminated = false,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: int.parse(json['id']),
        name: json['name'] as String,
        description: json['description'] != null ? json['description'] as String : null,
        pictureUrl: json['pict'] != null ? json['pict'] as String : null,
      );
}
