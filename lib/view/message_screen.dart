import 'package:bondlyze/model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:bondlyze/utils/responsive.dart';

class MessageScreen extends StatefulWidget {
  final String contactName;
  
  const MessageScreen({
    super.key,
    this.contactName = 'Charlotte',
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi, good morning Charlotte... 😳😳😳",
      isSent: true,
      time: "09:41",
      isRead: true,
    ),
    ChatMessage(
      text: "Hello, good morning too Andrew ☀️",
      isSent: false,
      time: "09:41",
    ),
    ChatMessage(
      text: "It seems we have a lot in common & have a lot of interest in each other 😏",
      isSent: true,
      time: "09:41",
      isRead: true,
    ),
    ChatMessage(
      text: "Haha, yes I've seen your profile and I'm a perfect match 😏😏😏",
      isSent: false,
      time: "09:41",
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.contactName,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.black),
            onPressed: () {},
          ),
          SizedBox(width: context.rw(8)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: context.rh(12)),
              children: [
                _DateSeparator(label: 'Today'),
                SizedBox(height: context.rh(16)),
                ..._messages.map((msg) => _ChatBubble(
                  message: msg,
                  primaryColor: primaryColor,
                )),
                SizedBox(height: context.rh(8)),
              ],
            ),
          ),
          _MessageInputField(
            controller: _messageController,
            primaryColor: primaryColor,
            onSend: () {
              if (_messageController.text.trim().isNotEmpty) {
                setState(() {
                  _messages.add(ChatMessage(
                    text: _messageController.text.trim(),
                    isSent: true,
                    time: _formatTime(DateTime.now()),
                    isRead: false,
                  ));
                });
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
 

class _DateSeparator extends StatelessWidget {
  final String label;

  const _DateSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: context.pxy(16, 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.rf(12),
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final Color primaryColor;

  const _ChatBubble({
    required this.message,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isSent) {
      return Padding(
        padding: EdgeInsets.only(
          left: context.rw(60),
          right: context.rw(16),
          bottom: context.rh(8),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: BoxConstraints(maxWidth: context.sw(0.75)),
            padding: context.pxy(12, 10),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.rw(16)),
                topRight: Radius.circular(context.rw(16)),
                bottomLeft: Radius.circular(context.rw(16)),
                bottomRight: Radius.circular(context.rw(4)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.rf(15),
                  ),
                ),
                SizedBox(height: context.rh(4)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.time,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: context.rf(11),
                      ),
                    ),
                    SizedBox(width: context.rw(4)),
                    Icon(
                      message.isRead ? Icons.done_all : Icons.done,
                      size: context.rf(16),
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          left: context.rw(16),
          right: context.rw(60),
          bottom: context.rh(8),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: context.sw(0.75)),
            padding: context.pxy(12, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.rw(16)),
                topRight: Radius.circular(context.rw(16)),
                bottomLeft: Radius.circular(context.rw(4)),
                bottomRight: Radius.circular(context.rw(16)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: context.rf(15),
                  ),
                ),
                SizedBox(height: context.rh(4)),
                Text(
                  message.time,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: context.rf(11),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class _MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final Color primaryColor;
  final VoidCallback onSend;

  const _MessageInputField({
    required this.controller,
    required this.primaryColor,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.pxy(8, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.grey[600]),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                padding: context.pxy(12, 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(context.rw(24)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Send message ...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: context.rf(15),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        style: TextStyle(fontSize: context.rf(15)),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    SizedBox(width: context.rw(8)),
                    Icon(
                      Icons.mic,
                      color: Colors.grey[600],
                      size: context.rf(22),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: context.rw(8)),
            Container(
              width: context.rw(48),
              height: context.rw(48),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: onSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}