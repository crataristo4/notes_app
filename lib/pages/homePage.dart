import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/constants/appConstants.dart';
import 'package:notes_app/model/api_service.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/pages/create_or_edit_notes.dart';
import 'package:notes_app/services/services.dart';
import 'package:notes_app/widgets/header.dart';
import 'package:notes_app/widgets/loading.dart';
import 'package:notes_app/widgets/swipe_to_delete_note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotesService get services => GetIt.instance<NoteServices>();

  // List<Notes> noteList = [];
  ApiReXponse<List<Notes>> apiResponse;
  bool isLoading = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    apiResponse = await services.getNotes();

    setState(() {
      isLoading = false;
    });
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
        body: isLoading ? Loading() : _body());
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
            key: ValueKey(apiResponse.data[index].noteId),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateOrEditNote(
                    noteId: apiResponse.data[index].noteId,
                  );
                }));
              },
              title: Text(
                apiResponse.data[index].noteTitle,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                'Last time edited : ${dateTimeFormatter(
                    apiResponse.data[index].createDateTime)}',
                style: TextStyle(
                    fontSize: AppConstants().font16, color: Colors.blue),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: apiResponse.data.length);
  }
}
