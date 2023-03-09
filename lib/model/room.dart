class Room {
  static const String collectionName= 'rooms';
  String roomId;
  String title;
  String description;
  String catrgoryId;
  Room(
      {required this.roomId,
      required this.title,
      required this.description,
      required this.catrgoryId});

  Room.fromJson(Map<String, dynamic> json)
      : this(
          roomId: json['room_id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          catrgoryId: json['catrgory_id'] as String,
        );
  Map<String, dynamic> toJson() {
    return {
      'room_id': roomId,
      'title': title,
      'description': description,
      'catrgory_id': catrgoryId
    };
  }
}
