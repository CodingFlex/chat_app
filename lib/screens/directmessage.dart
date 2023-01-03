// ignore_for_file: prefer_const_constructors

import 'package:chat_app/customui/ownmessage.dart';
import 'package:chat_app/customui/replycard.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/messagemodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../colors.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage(
      {super.key, required this.chatModel, required this.sourcechat});
  final ChatModel chatModel;
  final ChatModel sourcechat;

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  bool showEmojis = false;
  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  void initState() {
    super.initState();
    // connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojis = false;
        });
      }
    });
    connect();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://172.20.10.8:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourcechat.id);
    socket.onConnect((data) {
      if (kDebugMode) {
        print("Connected");
      }
      socket.on("message", (msg) {
        if (kDebugMode) {
          print(msg);
        }
        setMessage("destination", msg["message"]);
      });
    });
    if (kDebugMode) {
      print(socket.connected);
    }
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/wallpaper1.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            backgroundColor: AppColor.primaryChatColor,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 23,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            centerTitle: true,
            title: Column(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(widget.chatModel.imageUrl),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () {}),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: (() {
                if (showEmojis) {
                  setState(() {
                    showEmojis = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              }),
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height - 140,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: ((context, index) {
                      if (messages[index].type == "source") {
                        return OwnMessageCard(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      } else {
                        return ReplyMessageCard(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 59,
                            child: Card(
                              margin: EdgeInsets.only(
                                left: 2,
                                right: 2,
                                bottom: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                focusNode: focusNode,
                                controller: _controller,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                onChanged: (value) {
                                  if (value.length > 0) {
                                    setState(() {
                                      sendButton = true;
                                    });
                                  } else {
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.emoji_emotions),
                                    onPressed: () {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      setState(() {
                                        showEmojis = !showEmojis;
                                      });
                                    },
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomSheet());
                                        },
                                        icon: Icon(Icons.attach_file),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.camera_alt),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              right: 5,
                              left: 2,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              radius: 25,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  sendButton ? Icons.send : Icons.mic,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (sendButton) {
                                    sendMessage(
                                        _controller.text,
                                        widget.sourcechat.id,
                                        widget.chatModel.id);
                                    _controller.clear();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Offstage(
                        offstage: !showEmojis,
                        child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            textEditingController: _controller,
                            config: Config(
                              columns: 7,
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                            ),
                            onEmojiSelected: ((emoji, category) {}),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: AppColor.primaryChatColor,
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(
                    Icons.insert_drive_file,
                    Colors.black38,
                    "Document",
                  ),
                  SizedBox(width: 40),
                  iconcreation(
                    Icons.camera_alt,
                    Colors.black38,
                    "Camera",
                  ),
                  SizedBox(width: 40),
                  iconcreation(
                    Icons.insert_photo,
                    Colors.black38,
                    "Gallery",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
