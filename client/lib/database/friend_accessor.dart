import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/database/friend_queries.dart';
import 'package:link/models/friend.dart';

final friendAccessorProvider = Provider<FriendAccessor>((ref) {
  return FriendAccessor();
});

class FriendAccessor {
  Future<List<Friend>> getFriends() {
    return FriendQueries.queryAllFriends();
  }
}
