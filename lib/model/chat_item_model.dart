
class ChatItem {
  final String name;
  final String message;
  final String timeLabel;
  final int? unreadCount;
  const ChatItem({
    required this.name,
    required this.message,
    required this.timeLabel,
    this.unreadCount,
  });
}