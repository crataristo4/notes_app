import 'package:flutter/material.dart';
import 'package:notes_app/constants/appConstants.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/pages/create_or_edit_notes.dart';
import 'package:notes_app/widgets/header.dart';
import 'package:notes_app/widgets/swipe_to_delete_note.dart';

class HomePage extends StatelessWidget {
  final noteList = [
    new Notes(
        noteId: "1",
        noteTitle: "Birthday",
        dateCreated: DateTime.now(),
        lastTimeEdited: DateTime.now()),
    new Notes(
        noteId: "2",
        noteTitle: "Sports Event",
        dateCreated: DateTime.now(),
        lastTimeEdited: DateTime.now()),
    new Notes(
        noteId: "3",
        noteTitle: "Christmas",
        dateCreated: DateTime.now(),
        lastTimeEdited: DateTime.now()),
  ];

  String dateTimeFormatter(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _fab(context),
        body: _body());
  }

  //floating action
  _fab(context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CreateOrEditNote();
        }));
      },
      hoverColor: Colors.green,
      backgroundColor: Colors.amber,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      tooltip: AppConstants().addNote,
    );
  }

  //body
  _body() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(AppConstants().margin8),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (onDismissed) {},
            confirmDismiss: (confirmDismiss) async {
              final results = await showDialog(
                  context: context,
                  builder: (_) {
                    return SwipeToDeleteNote();
                  });
              print(results);
              return results;
            },
            key: ValueKey(noteList[index].noteId),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateOrEditNote(
                    noteId: noteList[index].noteId,
                  );
                }));
              },
              title: Text(
                noteList[index].noteTitle,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                'Last time edited : ${dateTimeFormatter(noteList[index].dateCreated)}',
                style: TextStyle(
                    fontSize: AppConstants().font16, color: Colors.blue),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: noteList.length);
  }
}
