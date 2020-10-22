// import 'package:flutter/material.dart';
// import 'package:guftgu/Pages/message_box.dart';
// import 'package:guftgu/Pages/users.dart';
// import 'package:guftgu/chatBox.dart';

// class RecentChats extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 500,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10.0),
//             topRight: Radius.circular(10.0),
//           )),
//       child: ClipRRect(
//         // Round rectangle clip whereas ClipRect is only rectangle clip
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10.0),
//           topRight: Radius.circular(10.0),
//         ),
//         child: ListView.builder(
//             itemCount: chats.length,
//             itemBuilder: (BuildContext context, int index) {
//               final Message chat = chats[index];
//               return GestureDetector(
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => ChatScreen(
//                               user: chat.sender,
//                             ))),
//                 child: Container(
//                   margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                   decoration: BoxDecoration(
//                     color: chat.unread ? Colors.amber[50] : Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10.0),
//                         topRight: Radius.circular(10.0)),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment
//                         .spaceBetween, // to evenly place the children at the end of the rows
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 35.0,
//                             backgroundImage: AssetImage(chat.sender.imageUrl),
//                             backgroundColor: Colors.grey[400],
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 chat.sender.name,
//                                 style: TextStyle(
//                                   fontSize: 15.0,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width *
//                                     0.50, // 50% of the container containng the message recieved.
//                                 child: Text(
//                                   chat.text,
//                                   style: TextStyle(
//                                     fontSize: 15.0,
//                                     color: Colors.blueGrey,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   overflow: TextOverflow
//                                       .ellipsis, // to cut off the overflown text
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             chat.time,
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 5.0,
//                           ),
//                           chat.unread
//                               ? Container(
//                                   width: 40.0,
//                                   height: 20.0,
//                                   decoration: BoxDecoration(
//                                     color: Colors.redAccent,
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   ),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "New",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ))
//                               : Text(''),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
