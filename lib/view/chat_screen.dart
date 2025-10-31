import 'package:bondlyze/model/chat_item_model.dart';
import 'package:bondlyze/view/widget/chat_tile.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  final List<ChatItem> _chats = const [
    ChatItem(
      name: 'Charlotte',
      message: "Haha, yes I've seen your profil...",
      timeLabel: '09:41',
      unreadCount: 1,
    ),
    ChatItem(
      name: 'Aurora',
      message: 'Wow, this is really epic 👍',
      timeLabel: '08:54',
      unreadCount: 3,
    ),
    ChatItem(
      name: 'Victoria',
      message: 'Thank you so much andrew 🔥',
      timeLabel: '01:27',
    ),
    ChatItem(
      name: 'Emilia',
      message: 'Wow love it! ❤️',
      timeLabel: 'Yesterday',
      unreadCount: 2,
    ),
    ChatItem(
      name: 'Natalie',
      message: "I know... I'm trying to get the ...",
      timeLabel: 'Yesterday',
    ),
    ChatItem(
      name: 'Scarlett',
      message: "It's strong not just fabulous!😁",
      timeLabel: 'Dec 20, 2023',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title:   Text('Chats'),
        centerTitle: true,

      ),
      body:  Expanded(
            child: ListView.separated(
              itemCount: _chats.length,
              separatorBuilder: (_, __) => SizedBox(),
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return ChatTile(
                  chat: chat,
                  badgeColor: colorScheme.primary,
                );
              },
            ),
          ),
    );
  }
}