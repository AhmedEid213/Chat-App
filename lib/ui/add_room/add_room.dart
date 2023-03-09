import 'dart:async';

import 'package:chat_app/model/gategory.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/ui/add_room/add_room_navigator.dart';
import 'package:chat_app/ui/add_room/add_room_view_model.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;


class AddRoom extends StatefulWidget {
  static const String routeName = 'add_room';
  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigatort {
  AddRoomViewModel viewModel = AddRoomViewModel();
  String roomTitle = '';
  String roomDescription = '';
  var formKey = GlobalKey<FormState>();
  var catrgoryList = Category.getCategory();
  late Category selectedItem;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectedItem = catrgoryList[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Add Room'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ]),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create New Room',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 18),
                      Image.asset('assets/images/group.png'),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Enter Room Title'),
                        onChanged: (text) {
                          roomTitle = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Room Title';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<Category>(
                                value: selectedItem,
                                items: catrgoryList
                                    .map((category) => DropdownMenuItem<Category>(
                                        value: category,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(category.title),
                                            SizedBox(width: 170),
                                            Image.asset(
                                              category.image,
                                              height: 35,
                                            )
                                          ],
                                        )))
                                    .toList(),
                                onChanged: (newCategory) {
                                  if (newCategory == null) return;
                                  selectedItem = newCategory;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter Room Title',
                          ),
                          minLines: 2,
                          maxLines: 3,
                          onChanged: (text) {
                            roomDescription = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Room Description';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(height: 18),
                      ElevatedButton(onPressed: () {
                        validateForm();
                      }, child: Text('Add Room'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  void validateForm() {
    if(formKey.currentState?.validate()== true){
      //add room
      viewModel.addRoom(roomTitle, roomDescription, selectedItem.id);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void navigateToHome(Room room) {
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  void showLoading() {
    Utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context,
        'ok',
        (context){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
  }
}
