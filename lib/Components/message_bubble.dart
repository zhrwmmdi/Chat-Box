import 'package:chat_box/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? message, sender;
  final bool? isMe;
  const MessageBubble({super.key, this.message, this.sender, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
        child: Material(
          borderRadius:  BorderRadius.only(
              topLeft: isMe! ? Radius.circular(20) : Radius.circular(0),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: isMe! ? Radius.circular(0) : Radius.circular(20)
          ),
          color: isMe! ? kLoginButtonColor : kRegisterButtonColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  sender!,
                  style: const TextStyle(
                      fontSize: 12,
                      color: kChatEmailColor
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  message!,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}