import 'package:flutter/material.dart';
import 'package:notes_app/constants/appConstants.dart';

AppBar header(context,
    {bool isAppTitle = false, String title, bool removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      isAppTitle ? AppConstants().title : title,
      style: TextStyle(
          fontFamily: isAppTitle ? "Signatra" : "",
          fontSize:
              isAppTitle ? AppConstants().margin32 : AppConstants().font24,
          color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
  );
}
