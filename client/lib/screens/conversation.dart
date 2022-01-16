import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/models/message.dart';
import 'package:link/state/db.dart';

class ConversationArguments {
  final String conversationId;

  ConversationArguments(this.conversationId);
}

class ConversationScreen extends ConsumerWidget {
  const ConversationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ConversationArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation"),
      ),
      body: ref.watch(messagesProvider(args.conversationId)).when(
        data: (messages) {
          return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [_buildRow(messages[i])],
                );
              });
        },
        error: (_, __) {
          return const Text("Error");
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildRow(Message message) {
    final bool fromYou = message.sender == null;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        mainAxisAlignment:
            fromYou ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: fromYou ? Colors.white : Colors.lightBlue,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                )),
            child: Text(message.body),
          ),
        ],
      ),
    );
  }
}
