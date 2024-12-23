import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  ChatListItem({
    required this.content,
    required this.isReceived,
  });

  final bool isReceived;
  final String content;
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isReceived ?Alignment.centerLeft :Alignment.centerRight ,
      child: Container(
        decoration: BoxDecoration(
          color: isReceived ? Colors.purple[200] : Colors.grey[200],
          borderRadius: BorderRadius.circular(16)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: isReceived ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
