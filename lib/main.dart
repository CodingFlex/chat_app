// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:chat_app/screens/camerascreen.dart';
import 'package:chat_app/screens/logindemo.dart';
import 'package:chat_app/screens/roomshome.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "OpenSans",
          primaryColor: const Color(0xFF075E54),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF128C7E))),
      home: LoginDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}
