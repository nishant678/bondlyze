import 'package:bondlyze/model/chat_item_model.dart';
import 'package:flutter/material.dart';


class ChatTile extends StatelessWidget {
  final ChatItem chat;
  final Color badgeColor;

  const ChatTile({required this.chat, required this.badgeColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            child: Text(chat.name[0]),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          )
        ],
      ),
      title: Text(
        chat.name,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        chat.message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat.timeLabel,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          if (chat.unreadCount != null && chat.unreadCount! > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                chat.unreadCount.toString(),
                style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
              ),
            ),
        ],
      ),
      onTap: () {},
    );
  }
}