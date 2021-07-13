import 'package:GroceryApp/sizeConfig.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class CameraScreen extends StatefulWidget {
  static String routeName = '/camera';
  const CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    CameraController _controller;

    Future<void> initCamera() async {
      var cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      await _controller.initialize();
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    Future<File> takePicture() async {
      Directory root = await getTemporaryDirectory();
      String directoryPath = '${root.path}/Guided_Camera';
      await Directory(directoryPath).create(recursive: true);
      String filePath = '$directoryPath/${DateTime.now()}.jpg'; 

      try {
        await _controller.takePicture(filePath);
      } catch (e) {
        print(e.toString());
        return null;
      }

      return File(filePath);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: initCamera(),
          builder: (_, snapshot) => (snapshot.connectionState ==
                  ConnectionState.done)
              ? Container(
                  child: Stack(
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width /
                              _controller.value.aspectRatio,
                          child: CameraPreview(_controller),
                        ),
                        Container(
                          width: getFlexibleWidth(90),
                          height: getFlexibleHeight(90),
                          margin: EdgeInsets.only(top: getFlexibleHeight(30)),
                          child: Material(
                            shape: CircleBorder(),
                            color: Colors.blue,
                            child: InkWell(
                              onTap: () async {
                                if(!_controller.value.isTakingPicture){
                                  File result = await takePicture();
                                  Navigator.pop(context, result);
                                }
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              : Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
