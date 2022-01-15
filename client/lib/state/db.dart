import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/database/friend_accessor.dart';

import '../models/friend.dart';

final friendsProvider = FutureProvider<List<Friend>>((ref) async {
  return ref.read(friendAccessorProvider).getFriends();
});
