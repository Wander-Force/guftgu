import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var msgTextController = TextEditingController();
  var authc = FirebaseAuth.instance;
  var fireStoreInstance = FirebaseFirestore.instance;

  String messageInput;
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var signInUser = authc.currentUser.email;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: fireStoreInstance
                  .collection("chat groups")
                  .doc("o5RPsr7DV70FkYe0pox6")
                  .collection("messages")
                  .snapshots(),
              builder: (context, snapshot) {
                //if (snapshot.data == null) return CircularProgressIndicator();

                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.data == null) {
                  print('****STILL NULL');
                }

                print('******* NEW DATA INCOMING*******');
                var msg = snapshot.data.docs;
                print(msg);

                List<Widget> msgList = [];
                for (var param in msg) {
                  var msgText = param.data()['text'];
                  var msgSender = param.data()['sender'];
                  var msgWidget = Text("$msgText : $msgSender");

                  msgList.add(msgWidget);
                }
                print(msgList);

                return Container(
                  child: Column(
                    children: msgList,
                  ),
                );
              },
              initialData: null,
            ),
            Row(
              children: [
                Container(
                  width: deviceWidth * 0.70,
                  child: TextField(
                    controller: msgTextController,
                    decoration: InputDecoration(hintText: 'Enter message..'),
                    onChanged: (value) {
                      messageInput = value;
                    },
                  ),
                ),
                Container(
                  width: deviceWidth * 0.20,
                  child: FlatButton(
                    child: Text('send'),
                    onPressed: () async {
                      msgTextController.clear(); //doubt: what this doing?

                      DateTime currentTime = DateTime.now();

                      await fireStoreInstance
                          .collection("chat groups")
                          .doc("o5RPsr7DV70FkYe0pox6")
                          .collection("messages")
                          .add({
                        "body": messageInput,
                        "sender": signInUser,
                        "time": currentTime.toString(),
                      });

                      print(signInUser);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
