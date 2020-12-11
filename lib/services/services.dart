import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes_app/constants/appConstants.dart';
import 'package:notes_app/model/api_service.dart';
import 'package:notes_app/model/notes_model.dart';

abstract class NotesServicesAbstract {
  /// Future<ApiService<List<Notes>>> getNotes();
  Future<List<Notes>> getNotes();
}

class NoteService implements NotesServicesAbstract {
  static get headers => {"apiKey": AppConstants().apiKey};

  String url = AppConstants.baseUrl + AppConstants.endPoint;

  @override
  Future<List<Notes>> getNotes() async {
    List<Notes> notesList = [];

    Response response = await http.get(url, headers: headers);
    notesList = notesFromJson(response.body);

    return notesList;
  }
/*  @override
  List<Notes> getNotes() {
    return [
      Notes(
          noteId: "1",
          noteTitle: "Birthday",
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now()),
      Notes(
          noteId: "2",
          noteTitle: "Sports Event",
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now()),
      Notes(
          noteId: "3",
          noteTitle: "Christmas",
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now()),
    ];
  }*/
}

abstract class NotesService {
  Future<ApiReXponse<List<Notes>>> getNotes();
}

class NoteServices implements NotesService {
  static get headers => {"apiKey": AppConstants().apiKey};
  final notesList = <Notes>[];
  String url = AppConstants.baseUrl + AppConstants.endPoint;

  @override
  Future<ApiReXponse<List<Notes>>> getNotes() {
    return http.get(url, headers: headers).then((data) {
      if (data.statusCode == 200) {
        var jsonData = jsonDecode(data.body);

        for (var items in jsonData) {
          final notes = Notes(
            noteId: items["noteId"],
            noteTitle: items["noteTitle"],
            createDateTime: DateTime.parse(items["createDateTime"]),
            latestEditDateTime: items["latestEditDateTime"] != null
                ? DateTime.parse(items["latestEditDateTime"])
                : null,
          );

          notesList.add(notes);
        }

        return ApiReXponse<List<Notes>>(data: notesList);
      }
      //if there is an error
      return ApiReXponse<List<Notes>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return ApiReXponse<List<Notes>>(
          error: true, errorMessage: "An error occurred ");
    });
  }
}
