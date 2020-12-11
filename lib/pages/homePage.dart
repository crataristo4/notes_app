import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants/appConstants.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/widgets/header.dart';

class HomePage extends StatelessWidget {
  final noteList = [
    Notes(
        noteId: 1,
        noteTitle: "Birthday",
        dateCreated: DateTime.now(),
        lastTimeEdited: DateTime.now()),
    Notes(
        noteId: 2,
        noteTitle: "Sports Event",
        dateCreated: DateTime.now(),
        lastTimeEdited: DateTime.now()),
    Notes(
        noteId: 1,
        noteTitle: "Christmas",
        dateCreated: DateTime.now(),
        lastTimeEdited: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        hoverColor: Colors.green,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: AppConstants().addNote,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                noteList[index].noteTitle,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: noteList.length),
    );
  }
}
