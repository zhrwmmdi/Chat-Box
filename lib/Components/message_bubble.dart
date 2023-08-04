import 'package:chat_box/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? message, sender;
  const MessageBubble({super.key, this.message, this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        ),
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
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
    );
  }
}