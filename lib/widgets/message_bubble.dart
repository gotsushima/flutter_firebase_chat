import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  final bool isFirstInSequence;
  final String? userImage;
  final String? username;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe && isFirstInSequence)
            CircleAvatar(
              backgroundImage:
                  userImage != null ? NetworkImage(userImage!) : null,
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          if (!isMe && !isFirstInSequence)
            const SizedBox(width: 46), // アバターの幅分のスペース
          Container(
            margin: EdgeInsets.only(
              top: isFirstInSequence ? 8 : 4,
              bottom: 4,
              left: 8,
              right: 8,
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (isFirstInSequence && username != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 13, right: 13, bottom: 4),
                    child: Text(
                      username!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    color: isMe
                        ? theme.colorScheme.primary.withAlpha(200)
                        : theme.colorScheme.secondary.withAlpha(200),
                    borderRadius: BorderRadius.only(
                      topLeft: !isMe && isFirstInSequence
                          ? Radius.zero
                          : const Radius.circular(12),
                      topRight: isMe && isFirstInSequence
                          ? Radius.zero
                          : const Radius.circular(12),
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  constraints: const BoxConstraints(maxWidth: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      height: 1.3,
                      color: isMe
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSecondary,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          if (isMe && isFirstInSequence)
            CircleAvatar(
              backgroundImage:
                  userImage != null ? NetworkImage(userImage!) : null,
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          if (isMe && !isFirstInSequence)
            const SizedBox(width: 46), // アバターの幅分のスペース
        ],
      ),
    );
  }
}
