// import 'package:flutter/material.dart';

// import 'package:guftgu/Pages/message_box.dart';

// import 'package:guftgu/Pages/users.dart';

// class ChatScreen extends StatefulWidget {
//   final User user;

//   ChatScreen({this.user});
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
// //------------------------------------------------------------------------------------>
// //                          MESSAGE TEXT BOX
// //------------------------------------------------------------------------------------>
//   _buildMessage(Message message, bool isMe) {
//     return Container(
//       decoration: BoxDecoration(
//           color: isMe ? Colors.red[50] : Colors.amber[100],
//           borderRadius: isMe
//               ? BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   bottomLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0))
//               : BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0),
//                   bottomRight: Radius.circular(20.0))),
//       margin: isMe
//           ? EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//               left: 80.0,
//             )
//           : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
//       padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             message.time,
//             style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: 8.0,
//           ),
//           Text(message.text,
//               style: TextStyle(
//                   color: Colors.blueGrey,
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// //------------------------------------------------------------------------------------------------>
// //                                        MESSAGING TEXT FIELD
// //------------------------------------------------------------------------------------------------>

//   _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.0),
//       height: 70.0,
//       color: Colors.white,
//       child: Row(
//         children: [
//           Expanded(
//               child: TextField(
//             textCapitalization: TextCapitalization
//                 .sentences, // capitalizes first letters of sentences.
//             onChanged: (value) {},
//             decoration: InputDecoration.collapsed(
//               // .collapsed removes a red line which occurs with the text field in the UI
//               hintText: 'Send a message...',
//             ),
//           )),
//           IconButton(
//               icon: Icon(Icons.send),
//               iconSize: 25.0,
//               color: Colors.red[400],
//               onPressed: () {})
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red,
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         elevation: 0.0,
//         title: Text(widget.user.name,
//             style: TextStyle(
//               fontSize: 28.0,
//               fontWeight: FontWeight.bold,
//             )),
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context)
//             .unfocus(), // take down the keyboard when touched on the chatscreen
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.0),
//                     topRight: Radius.circular(20.0),
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.0),
//                     topRight: Radius.circular(20.0),
//                   ),
//                   child: ListView.builder(
//                       reverse: true, // to get messages in order- old to new
//                       padding: EdgeInsets.only(top: 15.0),
//                       itemCount: messages.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final Message message = messages[index];
//                         final bool isMe = message.sender.id == currentUser.id;
//                         return _buildMessage(message, isMe);
//                       }),
//                 ),
//               ),
//             ),
//             _buildMessageComposer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
