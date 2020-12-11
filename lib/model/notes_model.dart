import 'dart:convert';

List<Notes> notesFromJson(String str) =>
    List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

String notesToJson(List<Notes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notes {
  Notes({
    this.noteId,
    this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime,
  });

  String noteId;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        noteId: json["noteId"],
        noteTitle: json["noteTitle"],
        createDateTime: json["createDateTime"],
        latestEditDateTime: json["latestEditDateTime"],
      );

  Map<String, dynamic> toJson() => {
        "noteId": noteId,
        "noteTitle": noteTitle,
        "createDateTime": createDateTime,
        "latestEditDateTime": latestEditDateTime,
      };
}
