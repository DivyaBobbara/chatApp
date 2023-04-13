import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMsg = '';

  final _msgController = TextEditingController();

  void _sendMsg() async{
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    FirebaseFirestore.instance.collection('chat').add({
      'text' : _enteredMsg,
      'createdAt' : Timestamp.now(),
      'userId' : user?.uid ?? 0,
      'userName' : userData['userName'],
      'userImagee' : userData['image_url'],
    });
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _msgController,
            decoration: InputDecoration(labelText: 'Send a message'),
            onChanged: (val) {
              setState(() {
                _enteredMsg = val;
              });
            },
          )),
          IconButton(
            onPressed: _enteredMsg.trim().isEmpty ? null : _sendMsg,
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
