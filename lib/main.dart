import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/add_room/add_room.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoom.routeName:(context) => AddRoom(),
        ChatScreen.routeName:(context) => ChatScreen()
      },
      initialRoute: userProvider.firebaseUser == null ?
      LoginScreen.routeName:HomeScreen.routeName,
    );
  }
}
