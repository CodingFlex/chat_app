import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoShot extends StatefulWidget {
  const VideoShot({super.key, required this.path});
  final String path;

  @override
  State<VideoShot> createState() => _VideoShotState();
}

class _VideoShotState extends State<VideoShot> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path));

    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.crop_rotate,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.title,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              size: 27,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 150,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black38,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                maxLines: 6,
                minLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27,
                    ),
                    hintText: "Add Caption",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    suffixIcon: CircleAvatar(
                      backgroundColor: Colors.tealAccent[700],
                      radius: 27,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 27,
                      ),
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: CircleAvatar(
                radius: 33,
                backgroundColor: Colors.black38,
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
