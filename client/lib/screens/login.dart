import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/login.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = ref.watch(emailProvider);
    final EmailValidNotifier emailValidator =
        ref.read(emailValidatorProvider.notifier);
    final bool isEmailValid = ref.watch(emailValidatorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              onChanged: (text) {
                emailValidator.validate(text);
              },
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            Hero(
              tag: "sign_in_button",
              child: ElevatedButton(
                onPressed: !isEmailValid
                    ? null
                    : () {
                        Navigator.pushNamed(context, "/login/signIn");
                      },
                child: const Text("Sign in"),
              ),
            ),
            const SizedBox(height: 8.0),
            const Center(child: Text("or")),
            const SizedBox(height: 8.0),
            Hero(
              tag: "create_account_button",
              child: OutlinedButton(
                onPressed: !isEmailValid
                    ? null
                    : () {
                        Navigator.pushNamed(context, "/login/createAccount");
                      },
                child: const Text("Create account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
