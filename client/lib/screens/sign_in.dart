import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/state/user.dart';

import '../state/login.dart';

final _signInErrorMessageProvider = StateProvider<String?>((ref) {
  return null;
});

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = ref.watch(emailProvider);
    String? signInErrorMessage = ref.watch(_signInErrorMessageProvider);

    // No password input validation needed when signing in
    // Additionally, its TextEditingController doesn't need to be exposed
    final TextEditingController _passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                validator: (text) {
                  return validateEmail(text);
                },
                onChanged: (_) {
                  ref.read(_signInErrorMessageProvider.state).state = null;
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
                onChanged: (_) {
                  ref.read(_signInErrorMessageProvider.state).state = null;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
              ),
              if (signInErrorMessage != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      signInErrorMessage,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                ),
              const SizedBox(height: 32.0),
              Hero(
                tag: "sign_in_button",
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var loginErrorMessage =
                          await ref.read(userProvider.notifier).signIn(
                                emailController.text,
                                _passwordController.text,
                              );

                      if (loginErrorMessage != null) {
                        print("Invalid credentials");
                        ref.read(_signInErrorMessageProvider.state).state =
                            loginErrorMessage;
                        return;
                      }

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/",
                        (_) => false,
                      );
                    }
                  },
                  child: const Text("Sign in"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
