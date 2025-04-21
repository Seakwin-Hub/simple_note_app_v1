class NotedModel {
  final int? id;
  final String title;
  final String content;
  final String color;
  final String dateTime;

  NotedModel({
    this.id,
    required this.color,
    required this.content,
    required this.dateTime,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color,
      'dateTime': dateTime,
    };
  }

  factory NotedModel.fromMap(Map<String, dynamic> map) {
    return NotedModel(
      id: map['id'],
      title: map['title'],
      color: map['color'],
      content: map['content'],
      dateTime: map['dateTime'],
    );
  }
}
