import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:link/database/friend_queries.dart';
import 'package:link/models/friend.dart';
import 'package:link/models/incoming_firebase_message.dart';

import 'firebase_options.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb) {
    await handleMessage(message);
  }
  print('Handling a background message ${message.messageId}');
}

Future<void> handleMessage(
  RemoteMessage message,
) async {
  final IncomingFirebaseMessage dataMessage =
      IncomingFirebaseMessage.fromJson(message.data);

  print(dataMessage);
  switch (dataMessage.type) {
    case "friend-request":
      final friend = Friend(
        username: dataMessage.sender,
        isRequest: true,
      );

      await FriendQueries.addFriend(friend);
      break;
    default:
      return;
  }
}
