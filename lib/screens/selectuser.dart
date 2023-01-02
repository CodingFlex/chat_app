import 'package:flutter/material.dart';

class SelectUser extends StatefulWidget {
  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Select Contact"),
          ],
        ),
      ),
    );
  }
}
