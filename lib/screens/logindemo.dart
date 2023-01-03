import 'package:chat_app/screens/roomshome.dart';
import 'package:flutter/material.dart';

import '../customui/buttoncard.dart';
import '../model/chat_model.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  late ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Nifemi",
      icon: "person.svg",
      isGroup: false,
      time: "4:10",
      id: 1,
      imageUrl: "assets/images/Profilepictures/nifemi.jpg",
    ),
    ChatModel(
      name: "Joshua",
      icon: "person.svg",
      isGroup: false,
      time: "3:50",
      id: 2,
      imageUrl: "assets/images/Profilepictures/joshua.png",
    ),
    ChatModel(
      name: "Feranmi",
      icon: "person.svg",
      isGroup: false,
      time: "3:00",
      id: 3,
      imageUrl: "assets/images/Profilepictures/feranmi.jpg",
    ),
    ChatModel(
      name: "Sade",
      icon: "person.svg",
      isGroup: false,
      time: "1:50",
      id: 4,
      imageUrl: "assets/images/Profilepictures/sade.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatmodels.removeAt(index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (builder) => RoomsHome(
                  chatmodels: chatmodels,
                  sourcechat: sourceChat,
                ),
              ),
            );
          },
          child: ButtonCard(
            name: chatmodels[index].name,
            profileImage: chatmodels[index].imageUrl,
          ),
        ),
        itemCount: chatmodels.length,
      ),
    );
  }
}
