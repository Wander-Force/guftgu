import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:guftgu/chatroom.dart';
import 'package:guftgu/login.dart';
//import 'package:guftgu/chat.dart';
import 'Test/chatroom2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat",
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "chatroom2": (context) => ChatRoom(),

        //------------------------------------------------EXAMPLAR----------------------------------------------->
        //  "/": (context) => LoginPage(),
        //   "Home": (context) => ChatRoom(),
        //   "ChatScreen": (context) => ChatScreen(),
      },
    );
  }
}
// Firebase SDK is not synced yet. Also SHA is not set... not sure if it'll be needed or not for chat live stream.
