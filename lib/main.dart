import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:guftgu/chat.dart';
import 'package:guftgu/login.dart';
import 'package:guftgu/signUp.dart';

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
        //'/': (context) => ActionAnimator(),
        "/": (context) => MySignUp(),
//        "/": (context) => MySignUp(),
        "chat": (context) => MyChat(),
        "login": (context) => MyLogin(),
      },
    );
  }
}
// Firebase SDK is not synced yet. Also SHA is not set... not sure if it'll be needed or not for chat live stream.
