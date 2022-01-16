import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/models/message.dart';

final messageAccessorProvider = Provider<FriendAccessor>((ref) {
  return FriendAccessor();
});

class FriendAccessor {
  Future<List<Message>> getMessages(String conversationId) {
    return Future.delayed(const Duration(seconds: 1), () {
      if (conversationId == "1") {
        return [
          Message(
            id: 1,
            body: "Hey what's up",
            sender: "Katie",
            sentInstant: 1642297400,
          ),
          Message(
            id: 2,
            body: "Hi how are you?",
            sender: null,
            sentInstant: 1642297410,
          ),
          Message(
            id: 3,
            body: "Great",
            sender: "Katie",
            sentInstant: 1642297420,
          ),
          Message(
            id: 4,
            body: "you too 😊",
            sender: null,
            sentInstant: 1642297430,
          ),
        ];
      } else if (conversationId == "2") {
        return [
          Message(
            id: 1,
            body: "Hey what's up",
            sender: "Spencer",
            sentInstant: 1642297400,
          ),
          Message(
            id: 2,
            body: "yeet",
            sender: null,
            sentInstant: 1642297410,
          ),
          Message(
            id: 3,
            body: "Great",
            sender: "Spencer",
            sentInstant: 1642297420,
          ),
          Message(
            id: 4,
            body: "you too 😊",
            sender: null,
            sentInstant: 1642297430,
          ),
        ];
      } else {
        return [];
      }
    });
  }
}
