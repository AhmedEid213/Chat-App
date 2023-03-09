import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget({required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: room);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]
        ),
        child: Column(
          children: [
            Image.asset('assets/images/${room.catrgoryId}.png',
                height: 100,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 12),
            Text(room.title),
          ],
        ),
      ),
    );
  }
}
