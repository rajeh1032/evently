class Event {
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String discription;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  Event(
      {this.id = '',
      required this.title,
      required this.discription,
      required this.image,
      required this.eventName,
      required this.dateTime,
      required this.time,
      this.isFavorite = false});

  //todo from json to object
  Event.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          title: data['title'],
          discription: data['discription'],
          image: data['image'],
          eventName: data['event_name'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['date_time']),
          time: data['time'],
          isFavorite: data['is_favorite'] ?? data['is_favorite'] ?? false,
        );
  //todo from object to json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'discription': discription,
      'image': image,
      'event_name': eventName,
      'date_time': dateTime.millisecondsSinceEpoch,
      'time': time,
      'is_favorite': isFavorite
    };
  }
}
