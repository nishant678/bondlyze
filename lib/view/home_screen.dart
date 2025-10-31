import 'package:bondlyze/config/color/app_color.dart';
import 'package:bondlyze/model/chat_item_model.dart';
import 'package:bondlyze/view/widget/active_avatar.dart';
import 'package:bondlyze/view/widget/chat_tile.dart';
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
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
                      child: Text(
                        'All',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.unselectedButtonColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
                      child: Text(
                        'Online',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                 Container(
                  decoration: BoxDecoration(
                    color: AppColors.unselectedButtonColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
                      child: Text(
                        'Followed',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                return ActiveAvatar(name: user.name);
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
                return ChatTile(
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
 
 
class _ActiveUser {
  final String name;
  const _ActiveUser({required this.name});
}
 