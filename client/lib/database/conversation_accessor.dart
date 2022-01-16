import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/models/conversation.dart';

final conversationAccessorProvider = Provider<FriendAccessor>((ref) {
  return FriendAccessor();
});

class FriendAccessor {
  Future<List<Conversation>> getConversations() {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        Conversation(id: "2", title: "😘 Katie", lastMessageInstant: 1642297400),
        Conversation(id: "1", title: "😀 Spencer", lastMessageInstant: 1642297410),
      ];
    });
  }
}
