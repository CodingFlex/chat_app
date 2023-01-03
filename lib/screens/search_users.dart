// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../colors.dart';

class SearchUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            SizedBox(
              width: 370,
              height: 40,
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.primaryChatColorLight,
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
                    hintText: "Search users"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
