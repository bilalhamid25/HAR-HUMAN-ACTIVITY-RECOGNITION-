import 'package:flutter/material.dart';
import 'package:har/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  storeonboard() async {
    int isviewed = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('onboard', isviewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 8,
              ),
              Text(
                'Introduction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          LottieBuilder.asset('assets/AI.json'),
          const Text(
            'Welcome to the HAR App for Mobile Devices. Our app is designed to detect human activities and provide real-time recognition capabilities, making it a cutting-edge solution for low-powered mobile devices. With its advanced deep learning algorithms, it is capable of accurately recognizing various human activities, making it an indispensable tool for security monitoring, healthcare, and human-computer interaction. ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomButton(
              text: 'Skip',
              onPressed: () async {
                await storeonboard();
                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CameraScreen();
                }));
              }),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            side: const BorderSide(color: Colors.blue)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}
