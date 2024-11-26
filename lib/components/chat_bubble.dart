import 'package:chats_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final bool isSender;

  const MessageBubble({
    Key? key,
    required this.messageText,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender
          ? Alignment.centerRight
          : Alignment.centerLeft, // Align based on sender status

      child: BubbleNormal(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        text: messageText, // Message text passed as a parameter
        //isSender: isSender, // Sender status passed as a parameter
        color: kPrimaryColor,
        isSender: true,
        tail: true,
        textStyle: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MessageBubbleForAFriend extends StatelessWidget {
  final String messageText;
  final bool isSender;

  const MessageBubbleForAFriend({
    Key? key,
    required this.messageText,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender
          ? Alignment.centerRight
          : Alignment.centerLeft, // Align based on sender status

      child: BubbleNormal(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        text: messageText, // Message text passed as a parameter
        //isSender: isSender, // Sender status passed as a parameter
        color: const Color.fromARGB(255, 58, 118, 197),
        isSender: false,
        tail: true,
        textStyle: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
