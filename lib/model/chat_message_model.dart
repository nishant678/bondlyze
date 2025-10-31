
class ChatMessage {
  final String text;
  final bool isSent;
  final String time;
  final bool isRead;

  ChatMessage({
    required this.text,
    required this.isSent,
    required this.time,
    this.isRead = false,
  });
}