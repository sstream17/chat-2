import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/state/user.dart';
import 'package:http/http.dart' as http;

import '../permissions.dart';
import '../token_monitor.dart';
import '../widgets/conversations.dart';
import '../widgets/meta_card.dart';

final _tokenProvider = StateProvider.autoDispose<String>((ref) => "");

class HomeScreen extends ConsumerWidget {
  final _textController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  Future<void> onActionSelected(
    String value,
    BuildContext context,
    WidgetRef ref,
  ) async {
    switch (value) {
      case 'signOut':
        await ref.read(userProvider.notifier).signOut();
        Navigator.pushReplacementNamed(context, "/");
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? _token = ref.watch(_tokenProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), actions: <Widget>[
        PopupMenuButton(
          onSelected: (String value) => onActionSelected(value, context, ref),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'signOut',
                child: Text('Sign Out'),
              ),
            ];
          },
        ),
      ]),
      body: Column(
        children: [
          const MetaCard('Permissions', Permissions()),
          MetaCard(
            'FCM Token',
            TokenMonitor((token) {
              return token == null
                  ? const CircularProgressIndicator()
                  : SelectableText(token, style: const TextStyle(fontSize: 12));
            }),
          ),
          TextField(
            controller: _textController,
            onChanged: (token) {
              ref.read(_tokenProvider.state).state = token;
            },
            onSubmitted: (_) {
              sendPushMessage(_token);
            },
            decoration: const InputDecoration.collapsed(hintText: 'FCM Token'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/friends");
            },
            child: const Text("Friends"),
          ),
          const Expanded(child: Conversations())
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await sendPushMessage(_token);
        },
        label: const Text("Send Request"),
        icon: const Icon(Icons.person_add),
      ),
    );
  }
}

Future<void> sendPushMessage(token) async {
  if (token == null) {
    print('Unable to send FCM message, no token exists.');
    return;
  }

  try {
    await http.post(
      Uri.parse('$firebaseFunctionUrl/sendMessage'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: constructFCMPayload(token),
    );
    print('FCM request for device sent!');
  } catch (e) {
    print(e);
  }
}

String constructFCMPayload(String? token) {
  return jsonEncode({
    'token': token,
    'sender': 'Spencer',
    'content': 'Hey dude! ${DateTime.now()}',
    'type': 'friend-request',
  });
}
