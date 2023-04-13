import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapShot) {
        if(futureSnapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDoc = snapshot.data?.docs;
        return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, ind) {
                return MessageBubble(
                    chatDoc?[ind]['text'] ?? "text", chatDoc?[ind]['userId']  == futureSnapShot.data?.uid, key: ValueKey(chatDoc?[ind].id),);
              },
              itemCount: chatDoc?.length ?? 0,
            );
          }
        );
      },

    );
  }
}
