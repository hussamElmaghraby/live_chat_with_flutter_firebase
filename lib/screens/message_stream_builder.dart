import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_chat/screens/message_text.dart';

class MessageStreambuilder extends StatefulWidget {
  const MessageStreambuilder({Key? key}) : super(key: key);

  @override
  State<MessageStreambuilder> createState() => _MessageStreambuilderState();
}

class _MessageStreambuilderState extends State<MessageStreambuilder> {
  final _fireStore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  User? signedInUser;
  @override
  void initState() {
    signedInUser = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snap) {
        List<MessageText> messageWidgets = [];
        if (!snap.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow[900],
            ),
          );
        }
        final messages = snap.data?.docs.reversed.toList();
        for (var message in messages ?? []) {
          final String messageText = message.get('text');
          final String messageSender = message.get('sender');
          log(messageSender);
          log("${signedInUser?.email}");

          final messageWidget = MessageText(
            isMe: signedInUser?.email! == messageSender,
            content: messageText,
            sender: messageSender,
          );
          messageWidgets.add(
            messageWidget,
          );
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
