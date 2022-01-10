import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/login.dart';

class CreateAccountScreen extends ConsumerWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = ref.watch(emailProvider);
    final EmailValidNotifier emailValidator =
        ref.read(emailValidatorProvider.notifier);
    final bool isEmailValid = ref.watch(emailValidatorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
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
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Hero(
              tag: "create_account_button",
              child: ElevatedButton(
                onPressed: !isEmailValid ? null : () {},
                child: const Text("Create account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
