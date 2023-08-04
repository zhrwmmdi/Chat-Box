import 'package:chat_box/Components/message_bubble.dart';
import 'package:chat_box/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  TextEditingController _messageTextController = TextEditingController();

  // void getMessages() async{
  //   var messages = await _fireStore.collection('messages').get();
  //   for( var message in messages.docs){
  //     print(message.data());
  //   }
  // }
  void messageStream(){
    _fireStore.collection('messages').snapshots().listen((event) {
      for( var message in event.docs){
        print(message.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSendButtonColor,
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pop(context);
                AuthService().signOut();
              }),
        ],
        title: Row(
          children: [

            Hero(
              tag: 'logo',
                child: Image.asset('images/logo.png', width: 50, height: 50,)),
            const Text('Chat'),
          ],
        )
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
                      controller: _messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _fireStore.collection('messages').add({
                        'date' : DateTime.now().millisecondsSinceEpoch,
                        'text' : _messageTextController.text,
                        'sender' : AuthService().getCurrentUser!.email
                      });
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

class MessageStream extends StatelessWidget {
  const MessageStream({
    super.key,
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
        builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Expanded(child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlue,),),);
        }
          if(snapshot.hasData){
            var messages = snapshot.data!.docs;
            List<Widget> messageBubbles = [];
            for(var message in messages){
              var messageText = message.get('text');
              var sender = message.get('sender');
              Widget messageBubble = MessageBubble(sender: sender ,message: messageText,);
              messageBubbles.add(messageBubble);
            }
            return Expanded(
              child: ListView(
                children: messageBubbles,
              ),
            );
          }else{
              return Center(child: Text('Snapshot has no data'),);
          }
        }
    );
  }
}

