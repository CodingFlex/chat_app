import 'package:chat_app/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/directmessage.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DirectMessage(
                chatModel: chatModel,
              ),
            ));
      }),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                chatModel.isGroup
                    ? "assets/svgs/groups.svg"
                    : "assets/svgs/person.svg",
                color: Colors.white,
                height: 33,
                width: 33,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(width: 3),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 18),
            child: Divider(thickness: 1),
          ),
        ],
      ),
    );
  }
}
