
class Note {
  int? id;
  String heading;
  String description;

  Note({this.id,required this.heading,required this.description});

  Note fromJson(json) {
    return Note(
        id: json['id'], heading: json['heading'], description: json['description']);
  }
  Map<String, dynamic> toJson() {
    return {'heading': heading, 'description': description};
  }
}
