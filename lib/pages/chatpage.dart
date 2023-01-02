// ignore_for_file: prefer_const_constructors

import 'package:chat_app/customui/customcard.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/screens/selectuser.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: "Nifemi",
      icon: "person.svg",
      isGroup: false,
      time: "4:10",
      currentMessage: "How far guy",
    ),
    ChatModel(
      name: "Mandem",
      icon: "groups.svg",
      isGroup: true,
      time: "4:00",
      currentMessage: "Ay no too get sense nau",
    ),
    ChatModel(
      name: "Joshua",
      icon: "person.svg",
      isGroup: false,
      time: "3:50",
      currentMessage: "Boss, send funds",
    ),
    ChatModel(
      name: "Feranmi",
      icon: "person.svg",
      isGroup: false,
      time: "3:00",
      currentMessage: "Werey, I dey game",
    ),
    ChatModel(
      name: "UniXP",
      icon: "groups.svg",
      isGroup: true,
      time: "2:00",
      currentMessage: "Omo we get meeting by 8:00pm o",
    ),
    ChatModel(
      name: "Emmanuel",
      icon: "person.svg",
      isGroup: false,
      time: "1:50",
      currentMessage: "You dey come class tomorrow?",
    ),
    ChatModel(
      name: "Kelvin",
      icon: "person.svg",
      isGroup: false,
      time: "1:40",
      currentMessage: "Steph is different brooo",
    ),
    ChatModel(
      name: "CSC Class of 2024",
      icon: "groups.svg",
      isGroup: true,
      time: "1:30",
      currentMessage: "We have CSC304 tomorrow o",
    ),
    ChatModel(
      name: "Bronesis",
      icon: "groups.svg",
      isGroup: true,
      time: "1:10",
      currentMessage: "Lmaoooo, wtf!",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (builder) => SelectUser(),
            ),
          );
        }),
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
      ),
    );
  }
}
