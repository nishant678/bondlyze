import 'package:bondlyze/config/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<_ActiveUser> _activeUsers = const [
    _ActiveUser(name: 'Ava'),
    _ActiveUser(name: 'Mia'),
    _ActiveUser(name: 'Liam'),
    _ActiveUser(name: 'Noah'),
    _ActiveUser(name: 'Emma'),
    _ActiveUser(name: 'Olivia'),
    _ActiveUser(name: 'Sophia'),
  ];

  final List<_ChatItem> _chats = const [
    _ChatItem(
      name: 'Charlotte',
      message: "Haha, yes I've seen your profil...",
      timeLabel: '09:41',
      unreadCount: 1,
    ),
    _ChatItem(
      name: 'Aurora',
      message: 'Wow, this is really epic 👍',
      timeLabel: '08:54',
      unreadCount: 3,
    ),
    _ChatItem(
      name: 'Victoria',
      message: 'Thank you so much andrew 🔥',
      timeLabel: '01:27',
    ),
    _ChatItem(
      name: 'Emilia',
      message: 'Wow love it! ❤️',
      timeLabel: 'Yesterday',
      unreadCount: 2,
    ),
    _ChatItem(
      name: 'Natalie',
      message: "I know... I'm trying to get the ...",
      timeLabel: 'Yesterday',
    ),
    _ChatItem(
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
        elevation: 0,
        titleSpacing: 0,
        title: const Text('Bondlyze'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.blur_on),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.unselectedButtonColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'All',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.unselectedButtonColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Online',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          SizedBox(
            height: 86,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final user = _activeUsers[index];
                return _ActiveAvatar(name: user.name);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemCount: _activeUsers.length,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _chats.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 84),
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return _ChatTile(
                  chat: chat,
                  badgeColor: colorScheme.primary,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveAvatar extends StatelessWidget {
  final String name;
  const _ActiveAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 28,
              child: Text(initials),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class _ChatTile extends StatelessWidget {
  final _ChatItem chat;
  final Color badgeColor;

  const _ChatTile({required this.chat, required this.badgeColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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

class _ActiveUser {
  final String name;
  const _ActiveUser({required this.name});
}

class _ChatItem {
  final String name;
  final String message;
  final String timeLabel;
  final int? unreadCount;
  const _ChatItem({
    required this.name,
    required this.message,
    required this.timeLabel,
    this.unreadCount,
  });
}