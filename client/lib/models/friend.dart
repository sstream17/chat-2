import 'package:link/models/user.dart';

class Friend extends User {
  bool isRequest;

  Friend({
    String? id,
    String? email,
    String? username,
    required this.isRequest,
  }) : super(
          id: id,
          email: email,
          username: username,
        );
}
