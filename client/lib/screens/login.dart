import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login/signIn");
              },
              child: const Text("Sign in"),
            ),
            const SizedBox(height: 8.0),
            const Center(child: Text("or")),
            const SizedBox(height: 8.0),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login/createAccount");
              },
              child: const Text("Create account"),
            ),
          ],
        ),
      ),
    );
  }
}
