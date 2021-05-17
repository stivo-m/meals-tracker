import 'package:meal_tracker/models/message_model.dart';

class MessageState {
  final List<Message> messages;
  final bool loading;

  MessageState({
    required this.messages,
    required this.loading,
  });

  MessageState.initialState()
      : this.messages = List<Message>.unmodifiable([]),
        this.loading = false;

  MessageState.copyWith({
    required List<Message> messages,
    required bool isLoading,
  })   : this.messages = messages,
        this.loading = isLoading;
}
