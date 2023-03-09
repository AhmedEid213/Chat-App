import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == message.senderId
        ? SentMessage(
            message: message,
          )
        : RecieveMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  Message message;
  SentMessage({required this.message});
   DateTime dateTime = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          child: Text(message.content, style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 6),
        Text(dateFormat(message),
            style: TextStyle(color: Colors.black)),
      ],
    );
  }
  String dateFormat(Message message){
    var date = DateTime.fromMillisecondsSinceEpoch(message.dateTime);
    return DateFormat('h:m a').format(date);

  }
}

class RecieveMessage extends StatelessWidget {
  Message message;
  RecieveMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: Text(message.content, style: TextStyle(color: Colors.black)),
        ),
        SizedBox(height: 6),

        Text(dateFormat(message),
            style: TextStyle(color: Colors.black)),
      ],
    );
  }
  String dateFormat(Message message){
    var date = DateTime.fromMillisecondsSinceEpoch(message.dateTime);
    return DateFormat('h:m a').format(date);

  }

}
