// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_function_literals_in_foreach_calls, use_build_context_synchronously, avoid_print

// import 'package:add_to_gallery/add_to_gallery.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'main.dart';

Future<http.Response> getData() async {
  final response = await http.post(Uri.parse("http://127.0.0.1:5000/predict"),
      body: "helloworld");
  return response;
}

void fetchData() async {
  final response = await getData();
  print('hello');
  if (response.statusCode == 200) {
    // handle the response
  } else {
    // handle the error
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  late Future<void> cameraValue;
  @override
  void initState() {
    _cameraController = CameraController(camera![0], ResolutionPreset.high);
    cameraValue = _cameraController!.initialize();
    // loadModel();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  loadCamera() {}
  String res = '';
  var predictions = [];
  // runModel(File image) async {
  //   if (image.path.isNotEmpty) {
  //     predictions = (await Tflite.runModelOnImage(
  //         path: image.path,
  //         numResults: 2,
  //         threshold: 0.05,
  //         imageMean: 127.5,
  //         imageStd: 127.5))!;
  //     predictions.map((element) {
  //       setState(() {
  //         output = element['label'];
  //       });
  //     });
  //     setState(() {
  //       print(predictions);
  //     });
  //   }
  // }

  // loadModel() async {
  //   res = (await Tflite.loadModel(
  //       model: "assets/model.tflite", labels: "assets/labels.txt"))!;
  //   print('models print $res');
  // }

  bool recent = false;
  bool flash = false;
  XFile? photo;

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  void takephoto() async {
    photo = await _cameraController!.takePicture();
    // runModel(File(photo!.path));

    _cameraController!.setFlashMode(FlashMode.off);
  }

  bool isrecording = false;
  int zoom = 1;
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GestureDetector(
                    onTap: () async {
                      await _cameraController!.setFocusMode(FocusMode.auto);
                    },
                    onLongPress: () async {
                      await _cameraController!.setFocusMode(FocusMode.locked);
                    },
                    child: CameraPreview(_cameraController!));
              }),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // IconButton(
                //     onPressed: () {
                //       // Get.back();
                //     },
                //     icon: Icon(
                //       CupertinoIcons.multiply,
                //       color: Colors.white,
                //     )),
                Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        if (recent == false) {
                          setState(() {
                            recent = true;
                          });
                        } else {
                          setState(() {
                            recent = false;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        height: recent == true ? 255 : 30,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: recent == true
                                      ? Colors.white38
                                      : Colors.transparent,
                                )),
                              ),
                              child: Center(
                                child: Text(
                                  'Recent Activities',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            recent == false
                                ? Container()
                                : Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white38)),
                                        ),
                                        child: Row(
                                          children: const [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Center(
                                              child: Text(
                                                '1. Walking while reading book',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white38)),
                                        ),
                                        child: Row(
                                          children: const [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Center(
                                              child: Text(
                                                '2. Sitting',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white38)),
                                        ),
                                        child: Row(
                                          children: const [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Center(
                                              child: Text(
                                                '3. Standing',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white38)),
                                        ),
                                        child: Row(
                                          children: const [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Center(
                                              child: Text(
                                                '4.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white38)),
                                        ),
                                        child: Row(
                                          children: const [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Center(
                                              child: Text(
                                                '5.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white38)),
                                        ),
                                        child: Row(
                                          children: const [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Center(
                                              child: Text(
                                                '6.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white38)),
                                        ),
                                        child: Row(
                                          children: const [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Center(
                                              child: Text(
                                                '7.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  output,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                // Column(
                //   children: [
                //     IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           Icons.list,
                //           color: Colors.white,
                //         )),
                //   ],
                // )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      FilePicker.platform.pickFiles(
                        type: FileType.video,
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/R.png'),
                      radius: 20,
                    ),
                  ),
                  Column(
                    children: [
                      Center(
                        child: GestureDetector(
                            // onLongPress: () async {
                            //   await _cameraController!.startVideoRecording();

                            //   setState(() {
                            //     isrecording = true;
                            //   });
                            // },
                            // onLongPressUp: () async {
                            //   photo = await _cameraController!.stopVideoRecording();

                            //   // Get.to(
                            //   //     sendVideo(
                            //   //       imagepath: photo!,
                            //   //       ChatId: widget.chatId,
                            //   //     ),
                            //   //     transition: Transition.rightToLeft);
                            //   setState(() {
                            //     isrecording = false;
                            //   });
                            // },
                            onTap: () async {
                              if (!isrecording) {
                                await _cameraController!.startVideoRecording();

                                setState(() {
                                  isrecording = true;
                                  fetchData();
                                });
                              } else {
                                photo = await _cameraController!
                                    .stopVideoRecording();
                                // fetchData();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        // title: Text('Save'),
                                        content: Container(
                                          height: 50,
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Text(
                                              'Do You Want To Save this Video to Gallery?',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Discard')),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    GallerySaver.saveVideo(
                                                        photo!.path);

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Save')),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                                // Get.to(
                                //     sendVideo(
                                //       imagepath: photo!,
                                //       ChatId: widget.chatId,
                                //     ),
                                //     transition: Transition.rightToLeft);
                                setState(() {
                                  isrecording = false;
                                });
                              }
                            },
                            child: Icon(
                              isrecording
                                  ? Icons.radio_button_on
                                  : Icons.panorama_fish_eye_outlined,
                              color: isrecording ? Colors.red : Colors.white,
                              size: 70,
                            )),
                      ),
                      Text(
                        'Tap for Start',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 20,
                  ),
                ],
              ),
            ]),
          )
        ],
      )),
    );
  }
}
