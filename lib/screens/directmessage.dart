// ignore_for_file: prefer_const_constructors

import 'package:chat_app/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  bool showEmojis = false;
  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojis = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 70,
        titleSpacing: 0,
        backgroundColor: Color(0xFF075E54),
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
              ),
              CircleAvatar(
                child: SvgPicture.asset(
                  widget.chatModel.isGroup
                      ? "assets/svgs/groups.svg"
                      : "assets/svgs/person.svg",
                  color: Colors.white,
                  height: 33,
                  width: 33,
                ),
                radius: 16,
                backgroundColor: Colors.blueGrey,
              ),
            ],
          ),
        ),
        title: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatModel.name,
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "last seen today at 12:05",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
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
            ListView(),
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
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) => bottomSheet());
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
                          backgroundColor: Color(0xFF128C7E),
                          radius: 25,
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.mic),
                            onPressed: () {},
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
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
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
                    Colors.indigo,
                    "Document",
                  ),
                  SizedBox(width: 40),
                  iconcreation(
                    Icons.camera_alt,
                    Colors.pink,
                    "Camera",
                  ),
                  SizedBox(width: 40),
                  iconcreation(
                    Icons.insert_photo,
                    Colors.purple,
                    "Gallery",
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(
                    Icons.headset,
                    Colors.orange,
                    "Audio",
                  ),
                  SizedBox(width: 40),
                  iconcreation(
                    Icons.location_pin,
                    Colors.teal,
                    "Location",
                  ),
                  SizedBox(width: 40),
                  iconcreation(
                    Icons.person,
                    Colors.blue,
                    "Contact",
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
