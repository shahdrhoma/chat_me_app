import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chats_project/constants.dart';

class Message {
  final String message;
  final String id;
  final Timestamp createdAt;

  Message({
    required this.message,
    required this.id,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json[kMessage] ?? '', // Fallback to an empty string
      id: json['id'] ?? '', // Fallback to an empty string
      createdAt:
          json['createdAt'] ?? Timestamp.now(), // Fallback to current time
    );
  }
}
