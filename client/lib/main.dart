import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/login/signIn': (context) => const SignInScreen(),
        '/login/createAccount': (context) => const CreateAccountScreen(),
      },
    );
  }
}
