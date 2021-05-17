import 'package:firebase_auth/firebase_auth.dart';

class Message {
  final User sender, recipient;
  final String message, id;
  final DateTime sentAt;
  final MessageStatus messageStatus;
  final MessageType messageType;

  Message({
    required this.sender,
    required this.recipient,
    required this.message,
    required this.id,
    required this.sentAt,
    required this.messageStatus,
    required this.messageType,
  });
}

enum MessageStatus {
  NOT_SENT,
  NOT_READ,
  READ,
}
enum MessageType {
  TEXT,
  IMAGE,
  VIDEO,
  AUDIO,
}
