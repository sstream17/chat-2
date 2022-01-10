import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacementNamed(context, "/");
        },
        label: const Text("Logout"),
        icon: const Icon(Icons.logout),
      ),
    );
  }
}
