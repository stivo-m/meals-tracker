import 'package:meal_tracker/models/message_model.dart';

abstract class MessageAction {}

class SendMessage implements MessageAction {
  final Message message;

  SendMessage({
    required this.message,
  });
}

class ReceiveMessages implements MessageAction {
  final List<Message> messages;

  ReceiveMessages({
    required this.messages,
  });
}
