import 'package:flutter/material.dart';
import 'package:notes_app/constants/appConstants.dart';

class SwipeToDeleteNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppConstants().deleteNote),
      content: Text(AppConstants().deleteDialog),
      actions: [
        //cancel button
        FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: Icon(
              Icons.cancel,
              color: Colors.green,
            ),
            label: Text(AppConstants().no)),

        //delete button
        FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            label: Text(
              AppConstants().yes,
              style: TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}
