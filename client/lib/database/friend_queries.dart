import 'package:link/database/link_database.dart';
import 'package:link/models/friend.dart';

class FriendQueries {
  static Future<List<Friend>> queryAllFriends() async {
    final db = await LinkDatabase.instance.database;
    final results = await db.query(friendsTableName);
    return results.isNotEmpty
        ? results.map((json) => Friend.fromJson(json)).toList()
        : [];
  }

  static Future<void> addFriend(Friend friend) async {
    final db = await LinkDatabase.instance.database;
    await db.insert(friendsTableName, friend.toJson());
  }
}
