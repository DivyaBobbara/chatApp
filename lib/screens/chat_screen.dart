import 'package:chat_app/widgets/chat/new_messages.dart';

import '../widgets/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          actions: [
            DropdownButton(
              icon: Icon(Icons.more_vert, color: Colors.red, size: 30),
              onChanged: (item_identifier) {
                if (item_identifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app),
                        Text('LogOut'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
            ),
          ],
        ),
        body: Container(child: Column(children: const [
          Expanded(child: Messages()),
          NewMessage(),
        ])),
        // floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.add),
        //     onPressed: () {
        //       FirebaseFirestore.instance
        //           .collection('chats/Xiloo3ZNk24zs7JO72Nt/messages')
        //           .add({
        //         'text': 'this was added by clicking button',
        //       });
        //     })
        );
  }
}
