import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants/appConstants.dart';
import 'package:notes_app/widgets/header.dart';

class CreateOrEditNote extends StatelessWidget {
  final TextEditingController txtNoteTitle = TextEditingController();
  final TextEditingController txtNoteContent = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  final String noteId;

  CreateOrEditNote({this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: header(context,
          isAppTitle: false,
          title: noteId == null
              ? AppConstants().createNote
              : AppConstants().editNote),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(AppConstants().margin16),
            child: TextField(
              controller: txtNoteTitle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: AppConstants().noteTitle,
                  hintText: AppConstants().noteTitleHint),
            ),
          ),
          SizedBox(
            height: AppConstants().margin8,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: AppConstants().margin16,
                right: AppConstants().margin16,
                bottom: AppConstants().margin16),
            child: TextField(
              controller: txtNoteContent,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  labelText: AppConstants().noteContent,
                  hintText: AppConstants().noteContentHint),
            ),
          ),
          SizedBox(
            height: AppConstants().margin32,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: AppConstants().margin16,
                right: AppConstants().margin16,
                bottom: AppConstants().margin16),
            child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants().margin8)),
                color: Colors.red,
                onPressed: () {
                  //save notes
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: EdgeInsets.all(AppConstants().margin8),
                  child: Text(
                    AppConstants().saveNote,
                    style: TextStyle(
                        color: Colors.white, fontSize: AppConstants().font24),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
