import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_chat/screens/message_stream_builder.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final messageController = TextEditingController();

  late User? signedInUser;
  String? message;

  void getCurrentUser() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        log("User Email : ${signedInUser?.email}");
      }
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }

  // getMessages() async {
  //   final messages = await _fireStore.collection('messages').get();
  //   for (var doc in messages.docs) {
  //     log(
  //       doc.data().toString(),
  //     );
  //   }
  // }

  void messageStream() {
    _fireStore
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((data) {
      for (var doc in data.docs) {
        log(
          doc.data().toString(),
        );
      }
    });
  }

  @override
  void initState() {
    getCurrentUser();
    messageStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Me'),
          backgroundColor: Colors.yellow[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Container(),
              const MessageStreambuilder(),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          _fireStore
                              .collection(
                            'messages',
                          )
                              .add(
                            {
                              'text': message,
                              'sender': signedInUser?.email,
                              'time': FieldValue.serverTimestamp(),
                            },
                          );
                          messageController.clear();
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(color: Colors.blue[800]),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
