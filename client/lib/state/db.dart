import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/database/friend_accessor.dart';

final friendsProvider = FutureProvider<List<String>>((ref) async {
  return ref.read(friendAccessorProvider).getFriends();
});
