import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailValidationRegex = RegExp(r"^(.+)@(.+)$");

final emailProvider = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());

String? validateEmail(String? email) {
  var _isValid = false;

  if (email != null) {
    _isValid = emailValidationRegex.hasMatch(email);
  }

  return _isValid ? null : "Please enter a valid email address";
}
