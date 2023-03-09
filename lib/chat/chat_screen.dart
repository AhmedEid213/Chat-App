import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/chat/chat_screen_view_model.dart';
import 'package:chat_app/chat/message_widget.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat_screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNvigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  String messageContent = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = provider.user!;
    viewModel.listenForUpdateMessages();
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
            title: Text(args.title),
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
            child: Column(
              children: [
                Expanded(child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.streamMessage,
                  builder: (context, asyncsnapshot) {
                    if(asyncsnapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator() ,
                      );
                    }else if(asyncsnapshot.hasError){
                      return Text(asyncsnapshot.hasError.toString());
                    }else {
                      var messageList = asyncsnapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
                      return ListView.builder(
                          itemBuilder: ((context, index) {
                            return MessageWidget(message: messageList[index]);
                          }),
                        itemCount: messageList.length,
                      );
                    }

                  },
                )
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: controller,
                      onChanged: (text) {
                        messageContent = text;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)))),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.sendMessage(messageContent);
                        },
                        child: Row(
                          children: [
                            Text('Send'),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.send_outlined,
                              size: 20,
                            )
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void clearMessage() {
    controller.clear();
  }
}
