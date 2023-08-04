import 'package:chat_box/Screens/chat_screen.dart';
import 'package:chat_box/Screens/login_screen.dart';
import 'package:chat_box/Screens/registration_screen.dart';
import 'package:chat_box/Screens/welcome_screen.dart';
import 'package:chat_box/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatBox());
}

class ChatBox extends StatelessWidget {
  ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              ChatScreen.id: (context) => ChatScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              LoginScreen.id: (context) => LoginScreen()
            },
            home: AuthService().getCurrentUser != null
                ? ChatScreen()
                : WelcomeScreen(),
          );
        });
  }
}
