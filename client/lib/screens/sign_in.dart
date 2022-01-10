import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/state/user.dart';

import '../state/login.dart';

final _auth = FirebaseAuth.instance;

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = ref.watch(emailProvider);
    final EmailValidNotifier emailValidator =
        ref.read(emailValidatorProvider.notifier);
    final bool isEmailValid = ref.watch(emailValidatorProvider);

    // No password input validation needed when signing in
    // Additionally, its TextEditingController doesn't need to be exposed
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
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
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Hero(
              tag: "sign_in_button",
              child: ElevatedButton(
                onPressed: !isEmailValid
                    ? null
                    : () async {
                        var loginSuccess =
                            await ref.read(userProvider.notifier).signIn(
                                  emailController.text,
                                  _passwordController.text,
                                );

                        if (!loginSuccess) {
                          print("Invalid credentials");
                          return;
                        }

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/",
                          (_) => false,
                        );
                      },
                child: const Text("Sign in"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
