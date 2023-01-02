import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chat_app/screens/takenshot.dart';
import 'package:chat_app/screens/videoshot.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          },
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        GestureDetector(
                          onLongPress: () async {
                            await _cameraController.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          },
                          onLongPressUp: () async {
                            XFile videopath =
                                await _cameraController.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => VideoShot(
                                  path: videopath.path,
                                ),
                              ),
                            );
                          },
                          onTap: () {
                            if (!isRecording) takePhoto(context);
                          },
                          child: isRecording
                              ? Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 80,
                                )
                              : Icon(
                                  Icons.panorama_fish_eye,
                                  color: Colors.white,
                                  size: 70,
                                ),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform = transform + pi;
                            });
                            int cameraPos = isCameraFront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          },
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Hold for video, tap for photo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => TakenShot(
          path: file.path,
        ),
      ),
    );
  }
}
