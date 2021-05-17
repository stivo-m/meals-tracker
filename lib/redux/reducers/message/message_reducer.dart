import 'package:meal_tracker/redux/actions/message/message_actions.dart';
import 'package:meal_tracker/redux/state/modules/message_state.dart';

MessageState messageReducer(MessageState messageState, dynamic action) {
  if (action is SendMessage) {
    return MessageState.copyWith(
      messages: messageState.messages..add(action.message),
      isLoading: false,
    );
  }
  if (action is ReceiveMessages) {
    return MessageState.copyWith(
      messages: action.messages,
      isLoading: false,
    );
  }

  return MessageState.copyWith(
    messages: messageState.messages,
    isLoading: messageState.loading,
  );
}
