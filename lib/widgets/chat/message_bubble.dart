import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  // final userId;
  // final userName;
  const MessageBubble(this.message,this.isMe,{required this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
            ),


          ),
          width: 150,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end :CrossAxisAlignment.start,
            children: [
              // FutureBuilder(builder: (ctx,snapshot) {
              //   if(snapshot.connectionState == ConnectionState.waiting) {
              //     return Text('..Loading!!');
              //   }
              //   return Text(snapshot.data?['userName']);
              // },future: FirebaseFirestore.instance.collection('users').doc(userId).get(),),
              // Text(userName),
              Text(message,textAlign: isMe ? TextAlign.end : TextAlign.start,style: TextStyle(color:Colors.white,),),
            ],
          ),
        ),
      ],
    );
  }
}
