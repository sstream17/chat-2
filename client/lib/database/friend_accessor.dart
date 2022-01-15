import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/models/friend.dart';

final friendAccessorProvider = Provider<FriendAccessor>((ref) {
  return FriendAccessor();
});

class FriendAccessor {
  Future<List<Friend>> getFriends() {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        Friend(username: "Spencer", isRequest: true),
        Friend(username: "Katie", isRequest: false),
      ];
    });
  }
}
