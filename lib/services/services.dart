import 'package:notes_app/model/notes_model.dart';

abstract class NotesServicesAbstract {
  List<Notes> getNotes();
}

class NoteServices implements NotesServicesAbstract {
  @override
  List<Notes> getNotes() {
    return [
      Notes(
          noteId: "1",
          noteTitle: "Birthday",
          dateCreated: DateTime.now(),
          lastTimeEdited: DateTime.now()),
      Notes(
          noteId: "2",
          noteTitle: "Sports Event",
          dateCreated: DateTime.now(),
          lastTimeEdited: DateTime.now()),
      Notes(
          noteId: "3",
          noteTitle: "Christmas",
          dateCreated: DateTime.now(),
          lastTimeEdited: DateTime.now()),
    ];
  }
}
