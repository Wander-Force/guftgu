import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guftgu/Pages/message_box.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  final name;
  final chatid;
  final email;

  ChatScreen({this.user, this.name, this.email, this.chatid}) : super();
  // these are the inputs coming from the previous page to use in this page. And this constructor is calling them.
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  final FirebaseAuth _authc = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  ScrollController scrollController = ScrollController();

  String messageBody;
  bool isWriting;

  Future<void> addNewMessage() async {
    DateTime _date = DateTime.now();

    DocumentReference reference = FirebaseFirestore.instance
        .collection('chat groups')
        .doc('${widget.chatid}')
        .collection('messages')
        .doc('$_date ${widget.user.email}');

    reference.set({
      'sender': widget.user.email,
      'body': messageBody,
      'time': _date.toString()
    });
    print('Document Reference is $reference');
  }

//------------------------------------------------------------------------------------>
//                          MESSAGE TEXT BOX
//------------------------------------------------------------------------------------>
  _buildMessage(Message message, bool isMe) {
    return Container(
      decoration: BoxDecoration(
          color: isMe ? Colors.red[50] : Colors.amber[100],
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))
              : BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0))),
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: 80.0,
            )
          : EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.time.toString().substring(0, 16),
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(message.text,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------------------------>
//                                        MESSAGING TEXT FIELD
//------------------------------------------------------------------------------------------------>

// void chatSaver(String messageBody){
// messageBody == null ? null : addNewMessage()

// }

//------------------------------------------------------------------------------------------------>
//                                        MESSAGING TEXT FIELD
//------------------------------------------------------------------------------------------------>

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textCapitalization: TextCapitalization
                .sentences, // capitalizes first letters of sentences.
            onChanged: (value) {
              messageBody = value;
              isWriting = value.length > 0;
            },
            decoration: InputDecoration.collapsed(
              // .collapsed removes a red line which occurs with the text field in the UI
              hintText: 'Send a message...',
            ),
          )),
          IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: Colors.red[400],
              onPressed: () {
                messageBody.length > 0 ? addNewMessage() : null;
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text(widget.name,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), // take down the keyboard when touched on the chatscreen
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: StreamBuilder(
                      stream: fireStore
                          .collection('chat groups')
                          .doc('${widget.chatid}')
                          .collection('messages')
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.data.documents.length);
                        if (snapshot.hasError) {
                          return CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                              reverse:
                                  true, // to get messages in order- old to new
                              padding: EdgeInsets.only(top: 15.0),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                //final Message message = messages[index];
                                final Message message = new Message(
                                    sender: snapshot.data.docs[index]['sender'],
                                    time: snapshot.data.docs[index]['time'],
                                    text: snapshot.data.docs[index]['body']);
                                print('**** MESSAGE: $message');
                                final bool isMe =
                                    message.sender == widget.email;
                                return _buildMessage(message, isMe);
                              });
                        }
                      }),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
