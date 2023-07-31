import 'package:chat_box/Screens/chat_screen.dart';
import 'package:chat_box/Screens/login_screen.dart';
import 'package:chat_box/Screens/registration_screen.dart';
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
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        LoginScreen.id : (context) => LoginScreen()
      },
      initialRoute: WelcomeScreen.id,
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: kBackgroundColor,
      // ),
      home: WelcomeScreen(),
    );
  }
}