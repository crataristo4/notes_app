import 'package:flutter/material.dart';
import 'package:notes_app/constants/appConstants.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/pages/create_or_edit_notes.dart';
import 'package:notes_app/services/services.dart';
import 'package:notes_app/widgets/header.dart';
import 'package:notes_app/widgets/swipe_to_delete_note.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NoteServices get services => GetIt.instance<NoteServices>();
  List<Notes> noteList = [];

  @override
  void initState() {
    noteList = services.getNotes();
    super.initState();
  }

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
