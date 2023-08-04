import 'package:chat_box/Components/message_stream.dart';
import 'package:chat_box/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int? hour, minute;
  final _fireStore = FirebaseFirestore.instance;
  final TextEditingController _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE0E0E0),
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: kLoginButtonColor,
              size: 30,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              AuthService().signOut();
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/logo.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                const Text(
                  'Chat',
                  style: TextStyle(
                      color: kLoginButtonColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              AuthService().getCurrentUser!.email!,
              style: const TextStyle(fontSize: 18, color: kLoginButtonColor),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(fireStore: _fireStore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        _fireStore.collection('messages').add(
                          {
                            'date': DateTime.now().millisecondsSinceEpoch,
                            'text': _messageTextController.text,
                            'sender': AuthService().getCurrentUser!.email,
                            'hour': DateTime.now().hour,
                            'minute': DateTime.now().minute
                          },
                        );
                        _messageTextController.clear();
                      },
                      controller: _messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      hour = DateTime.now().hour;
                      minute = DateTime.now().minute;
                      _fireStore.collection('messages').add(
                        {
                          'date': DateTime.now().millisecondsSinceEpoch,
                          'text': _messageTextController.text,
                          'sender': AuthService().getCurrentUser!.email,
                          'hour': DateTime.now().hour,
                          'minute': DateTime.now().minute
                        },
                      );
                      _messageTextController.clear();
                    },
                    child: const Icon(Icons.send,
                        size: 30, color: kSendButtonColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
