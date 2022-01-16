import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart' as link_user;

final _auth = FirebaseAuth.instance;

/// Use --dart-define=VAR_NAME=value
const firebaseFunctionUrl =
    String.fromEnvironment('FIREBASE_FUNCTION_URL', defaultValue: '');

final userProvider = StateNotifierProvider<UserNotifier, link_user.User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<link_user.User> {
  UserNotifier() : super(link_user.User());

  Future<String?> createAccount(
    String email,
    String password,
    String username,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('$firebaseFunctionUrl/createAccount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
          "username": username,
        }),
      );

      print(response);

      if (response.statusCode == 200) {
        await signIn(email, password);
        return null;
      }
    } catch (e) {
      return "Oops";
    }
    return "Oops";
  }

  Future<String?> signIn(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = userCredential.user;

      if (user != null) {
        state = link_user.User(
          userId: user.uid,
          email: user.email,
          username: user.displayName,
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
