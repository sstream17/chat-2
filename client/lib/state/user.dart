import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart' as link_user;

final _auth = FirebaseAuth.instance;

final userProvider = StateNotifierProvider<UserNotifier, link_user.User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<link_user.User> {
  UserNotifier() : super(link_user.User(null, null, null));

  Future<String?> signIn(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = userCredential.user;

      if (user != null) {
        state = link_user.User(
          user.uid,
          user.email,
          user.displayName,
        );

        return null;
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error:\n\t${e.code}\n\t${e.message}");
      switch (e.code) {
        case "invalid-email":
        case "user-not-found":
        case "wrong-password":
          return "Your email or password was incorrect";
      }
      return "We were unable to sign you in, please try again later";
    }

    return "We were unable to sign you in, please try again later";
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
