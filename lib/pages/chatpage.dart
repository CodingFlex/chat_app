// ignore_for_file: prefer_const_constructors

import 'package:chat_app/customui/customcard.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/screens/selectuser.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;

  const ChatPage(
      {super.key, required this.chatmodels, required this.sourcechat});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primaryChatColor,
        child: ListView.builder(
          itemCount: widget.chatmodels.length,
          itemBuilder: (context, index) => CustomCard(
            chatModel: widget.chatmodels[index],
            sourcechat: widget.sourcechat,
          ),
        ),
      ),
    );
  }
}
