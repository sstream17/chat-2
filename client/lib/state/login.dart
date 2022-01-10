import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailValidationRegex = RegExp(r"^(.+)@(.+)$");

final emailProvider = StateProvider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());

final emailValidatorProvider =
StateNotifierProvider.autoDispose<EmailValidNotifier, bool>((ref) {
  return EmailValidNotifier();
});

class EmailValidNotifier extends StateNotifier<bool> {
  EmailValidNotifier() : super(false);

  void validate(String email) {
    state = emailValidationRegex.hasMatch(email);
  }
}
