import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/database/conversation_accessor.dart';
import 'package:link/database/friend_accessor.dart';
import 'package:link/database/message_accessor.dart';
import 'package:link/models/conversation.dart';
import 'package:link/models/friend.dart';
import 'package:link/models/message.dart';

final friendsProvider = FutureProvider<List<Friend>>((ref) async {
  return ref.read(friendAccessorProvider).getFriends();
});

final conversationsProvider = FutureProvider<List<Conversation>>((ref) async {
  return ref.read(conversationAccessorProvider).getConversations();
});

final messagesProvider =
    FutureProvider.family<List<Message>, String>((ref, conversationId) async {
  return ref.read(messageAccessorProvider).getMessages(conversationId);
});
