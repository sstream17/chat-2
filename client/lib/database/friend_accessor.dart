import 'package:flutter_riverpod/flutter_riverpod.dart';

final friendAccessorProvider = Provider<FriendAccessor>((ref) {
  return FriendAccessor();
});

class FriendAccessor {
  Future<List<String>> getFriends() {
    return Future.delayed(const Duration(seconds: 1), () {
      return ["Spencer", "Katie"];
    });
  }
}
