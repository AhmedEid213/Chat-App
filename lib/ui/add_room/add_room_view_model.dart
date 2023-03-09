import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/ui/add_room/add_room_navigator.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier{
late AddRoomNavigatort navigator;
void addRoom(String roomTitle, String roomDescription , String catrgoryId)async{
  Room room = Room(
      roomId: '',
      title: roomTitle,
      description: roomDescription,
      catrgoryId: catrgoryId);
  try{
    navigator.showLoading();
    var createRoom = await DatabaseUtils.addRoomtoFireStore(room);
    navigator.hideLoading();
    navigator.showMessage('Room Was Added Successfuly');
    navigator.navigateToHome(room);

  }catch(e){
    navigator.hideLoading();
    navigator.showMessage(e.toString());

  }
}
}