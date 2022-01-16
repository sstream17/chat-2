import 'package:link/models/user.dart';

const String friendsTableName = "friends";

class FriendsTableFieldNames {
  static const String id = "_id";
  static const String userId = "user_id";
  static const String email = "email";
  static const String username = "username";
  static const String isRequest = "is_request";
}

class Friend extends User {
  int? id;
  bool isRequest;

  Friend({
    int? id,
    String? userId,
    String? email,
    String? username,
    required this.isRequest,
  }) : super(
          userId: userId,
          email: email,
          username: username,
        );

  factory Friend.fromJson(Map<String, Object?> json) => Friend(
        id: json[FriendsTableFieldNames.id] as int?,
        userId: json[FriendsTableFieldNames.userId] as String?,
        email: json[FriendsTableFieldNames.email] as String?,
        username: json[FriendsTableFieldNames.username] as String?,
        isRequest: json[FriendsTableFieldNames.isRequest] == 1,
      );

  Map<String, Object?> toJson() => {
        FriendsTableFieldNames.id: id,
        FriendsTableFieldNames.userId: userId,
        FriendsTableFieldNames.email: email,
        FriendsTableFieldNames.username: username,
        FriendsTableFieldNames.isRequest: isRequest ? 1 : 0,
      };
}
