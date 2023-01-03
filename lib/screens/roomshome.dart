// ignore_for_file: prefer_const_constructors

import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/pages/camera.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class RoomsHome extends StatefulWidget {
  const RoomsHome(
      {super.key, required this.chatmodels, required this.sourcechat});
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;
  @override
  State<RoomsHome> createState() => _RoomsHomeState();
}

class _RoomsHomeState extends State<RoomsHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryChatColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryChatColor,
        leading: IconButton(
          padding: EdgeInsets.only(top: 15.0),
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          color: Colors.blueGrey,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logos/UniXpl.png',
                height: 20,
                width: 50,
              ),
              Text(
                'Connect Rooms',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              onPressed: () {}),
        ],
        bottom: TabBar(
          labelColor: Colors.blueGrey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.blueGrey,
          indicatorColor: Colors.amber,

          controller: _controller,

          // ignore: prefer_const_literals_to_create_immutables
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "MESSAGES",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourcechat: widget.sourcechat,
          ),
        ],
      ),
    );
  }
}
