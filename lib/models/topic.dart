class Topic {
  int? id;
  String title;
  String description;
  int color;
  bool isRemoveAble = true;

  Topic({this.id,required this.title,required this.description, required this.color, this.isRemoveAble = true});

  Topic fromJson(json) {
    return Topic(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        color: json['color'],
        isRemoveAble: json['isRemoveAble']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'color' : color,
      'isRemoveAble' : isRemoveAble
    };
  }
}
