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
        child: Material (
          color: isMe! ? kLoginButtonColor : kRegisterButtonColor,
          borderRadius: isMe! ? const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
          ) : const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
          ),
          child:  Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(sender!, style: const TextStyle(
                    fontSize: 12,
                    color: kChatEmailColor
                ),),
                const SizedBox(height: 8,),
                Text(message!, style: const TextStyle(
                    fontSize: 16
                ),),
              ],
            ),
          ),

          //BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }
}