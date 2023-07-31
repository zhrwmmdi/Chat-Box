import 'package:chat_box/Screens/welcome_screen.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatBox());
}

class ChatBox extends StatelessWidget {
  ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: kBackgroundColor,
      // ),
      home: WelcomeScreen(),
    );
  }
}