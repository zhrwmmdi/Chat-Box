import 'package:chat_box/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? message, sender;
  final bool? isMe;
  final int? hour, minute;
  const MessageBubble(
      {super.key,
      this.message,
      this.sender,
      this.isMe,
      this.hour,
      this.minute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
        child: Material(
          borderRadius: BorderRadius.only(
            topLeft:
                isMe! ? const Radius.circular(20) : const Radius.circular(0),
            bottomRight: const Radius.circular(20),
            bottomLeft: const Radius.circular(20),
            topRight:
                isMe! ? const Radius.circular(0) : const Radius.circular(20),
          ),
          color: isMe! ? kLoginButtonColor : kRegisterButtonColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment:
                  isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  sender!,
                  style: const TextStyle(fontSize: 14, color: kChatEmailColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  message!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff303030),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '$hour : $minute',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
