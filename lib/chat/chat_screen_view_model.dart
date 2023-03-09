import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel extends ChangeNotifier{
late ChatNvigator navigator;
late MyUser currentUser;
late Room room;
late Stream<QuerySnapshot<Message>> streamMessage;
void sendMessage(String content)async{
  Message message =Message(
      roomId: room.roomId,
      content: content,
      senderId: currentUser.id,
      senderName: currentUser.userName,
      dateTime: DateTime.now().millisecondsSinceEpoch
  );
  try{
    var res = await DatabaseUtils.insertMessage(message);
    navigator.clearMessage();

  }catch(error){
    navigator.showMessage(error.toString());
  }
}
void listenForUpdateMessages(){
  streamMessage = DatabaseUtils.getMessageFromFireStore(room.roomId);
}
}