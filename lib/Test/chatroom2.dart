import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'chat.dart';
import 'chatscreen2.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({this.user});
  final User user;
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _textController = new TextEditingController();
  String addEmail;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot;

  // creating two lists-> one for storing users and one for storing ongoing chata

  List<QueryDocumentSnapshot> users = []; //list of all users in the app
  List openChats = []; // List of recent chats
  List<int> currentUserIndices = []; // storage list
  List<String> userIDs = []; // List of IDs of users

  bool isLoading = true;
  String recipient;
  String recipientEmail;

  // Getting the list of users using the app
  void getUsers() async {
    print("Getting users");
    querySnapshot = await fireStore.collection('users').get();
    var docs = querySnapshot.docs;
    for (int i = 0; i < docs.length; i++) {
      users.add(docs[i]);
    }
    print('***** LIST OF USERS :');
    users.forEach((element) {
      print(element.data());
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
    isLoading = false;
  }
  //----------------------------------------------------------------------->
  //              CREATING A NEW CHAT
  //----------------------------------------------------------------------->

  // Future<void> addChat(String email) async {
  //   List newChat = [widget.user.email, email];
  //   DocumentReference reference = await fireStore.collection('chatGroups').add({
  //     'title': 'Flutter in Action',
  //   });
  //   reference.set({'users': newChat});
  // }

  //------------------------------------------------------------------------->
  //                    GETTING MESSAGES SENT BY OUR USER
  //------------------------------------------------------------------------->
  int count = 0;
  getChats(AsyncSnapshot snapshot) {
    for (var i = 0; i < snapshot.data.documents.length; i++) {
      if (snapshot.data.documents[i]['users']
          .toString()
          .contains(widget.user.email.toString())) {
        count++;
        userIDs.add(snapshot.data.documents[i].documentID);
        currentUserIndices.add(i);
      }
    }
    print("$count user chats found");
  }

  //------------------------------------------------------------------------->
  //                    GETTING NAMES OF THE PEOPLE IN THE CONVERSATION
  //------------------------------------------------------------------------->

  List getRecipientsAndEmail(List emailList) {
    int c = 1;
    String recipient;
    String recipientEmail;
    for (var email in emailList) {
      if (email != widget.user.email) {
        for (var user in users) {
          if (user['email'] == email) {
            print("recipient $c = $email");
            recipient = user['name'];
            recipientEmail = email;
          }
          c++; // Hemabh keep c++ here, it will print recipient = not null
        }
      }
    }
    print("recipient: $recipientEmail");
    return [recipient, recipientEmail];
  }

  //-------------------------------------------------------------------------->

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            elevation: 0.0,
          ),
          body: Container(child: Center(child: CircularProgressIndicator())));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
        ),
        body: Container(
          height: 500,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              )),
          child: ClipRRect(
            // Round rectangle clip whereas ClipRect is only rectangle clip
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),

            child: StreamBuilder(
                stream: fireStore.collection('chat groups').snapshots(),
                builder: (context, snapshot) {
                  print("docs found : ${snapshot.data.docs.length}");
                  getChats(snapshot);
                  return ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        List recipientData = getRecipientsAndEmail(
                          snapshot.data.documents[currentUserIndices[index]]
                              .data()['users'],
                        );

                        recipient = recipientData[0];
                        recipientEmail = recipientData[1];

                        //final Message chat = chats[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ChatScreen(
                                      user: widget.user,
                                      name: recipient,
                                      email: recipientEmail,
                                      chatid: snapshot
                                          .data
                                          .documents[currentUserIndices[index]]
                                          .documentID
                                          .toString()))),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, right: 20.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.amber[50],
                              //chat.unread ? Colors.amber[50] : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // to evenly place the children at the end of the rows
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/person_110935.png'),
                                      backgroundColor: Colors.grey[400],
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          recipient != null
                                              ? recipient
                                              : "chat",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.50, // 50% of the container containng the message recieved.
                                          child: Text(
                                            snapshot.data.docs[index]
                                                // .collection('messages')
                                                // .document[0]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow
                                                .ellipsis, // to cut off the overflown text
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                // Column(
                                //   children: [
                                //     // Text(
                                //     //   chat.time,
                                //     //   style: TextStyle(
                                //     //       color: Colors.grey,
                                //     //       fontSize: 15.0,
                                //     //       fontWeight: FontWeight.bold),
                                //     // ),
                                //     SizedBox(
                                //       height: 5.0,
                                //     ),
                                //     // chat.unread
                                //     //     ? Container(
                                //     //         width: 40.0,
                                //     //         height: 20.0,
                                //     //         decoration: BoxDecoration(
                                //     //           color: Colors.redAccent,
                                //     //           borderRadius:
                                //     //               BorderRadius.circular(30.0),
                                //     //         ),
                                //     //         alignment: Alignment.center,
                                //     //         child: Text(
                                //     //           "New",
                                //     //           style: TextStyle(
                                //     //               color: Colors.white,
                                //     //               fontWeight: FontWeight.bold),
                                //     //         ))
                                //     //     : Text(''),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
        ),
      );
    }
  }
}
