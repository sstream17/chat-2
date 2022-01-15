import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link/state/db.dart';

import '../models/friend.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends"),
      ),
      body: const _FriendsBody(),
    );
  }
}

class _FriendsBody extends ConsumerWidget {
  const _FriendsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(friendsProvider).when(
      data: (friends) {
        return ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  _buildRow(friends[i]),
                  if (i != friends.length - 1) const Divider(),
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

  Widget _buildRow(Friend friend) {
    final isRequest = friend.isRequest;
    return ListTile(
      title: Text(
        friend.username!,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: isRequest
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel_rounded),
                ),
              ],
            )
          : null,
    );
  }
}
