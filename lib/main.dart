import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:har/home_screen.dart';
import 'package:har/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CameraDescription>? camera;
int? viewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  camera = await availableCameras();
  SharedPreferences pref = await SharedPreferences.getInstance();
  viewed = pref.getInt('onboard');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: viewed != 0 ? const IntroductionScreen() : const CameraScreen(),
    );
  }
}
