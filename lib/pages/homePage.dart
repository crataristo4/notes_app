import 'package:flutter/material.dart';
import 'package:notes_app/widgets/header.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,isAppTitle: true),

    );
  }
}
