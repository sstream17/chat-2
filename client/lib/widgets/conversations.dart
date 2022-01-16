import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/models/conversation.dart';
import 'package:link/screens/conversation.dart';
import 'package:link/state/db.dart';

class Conversations extends ConsumerWidget {
  const Conversations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(conversationsProvider).when(
      data: (conversations) {
        return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  _buildRow(context, conversations[i]),
                  if (i != conversations.length - 1) const Divider(),
                ],
              );
            });
      },
      error: (_, __) {
        return const Text("Error");
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildRow(BuildContext context, Conversation conversation) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/conversation",
          arguments: ConversationArguments(conversation.id),
        );
      },
      onDoubleTap: () {},
      onLongPress: () {},
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(
          conversation.title,
          style: const TextStyle(fontSize: 18.0),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }
}
