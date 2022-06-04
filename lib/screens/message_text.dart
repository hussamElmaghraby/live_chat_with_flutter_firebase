import 'package:flutter/material.dart';

class MessageText extends StatelessWidget {
  MessageText({
    Key? key,
    this.content,
    this.sender,
    required this.isMe,
  }) : super(key: key);
  String? content;
  String? sender;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            sender ?? '',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            color: isMe ? Colors.blue : Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$content',
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
