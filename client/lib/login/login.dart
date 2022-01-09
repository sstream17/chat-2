import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Text("Login"),
      ElevatedButton(
          onPressed: () async {
            await _auth.createUserWithEmailAndPassword(
                email: "sprewstream@gmail.com", password: "password");
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          },
          child: const Text("Sign in"))
    ]));
  }
}
