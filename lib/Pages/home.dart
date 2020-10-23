// import 'package:flutter/material.dart';
// import 'package:guftgu/widgets/category_selector.dart';
// import 'package:guftgu/widgets/recent_chats.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red[400],
//       appBar: AppBar(
//         backgroundColor: Colors.red[400],
//         leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
//         title: Text('Chats',
//             style: TextStyle(
//               fontSize: 28.0,
//               fontWeight: FontWeight.bold,
//             )),
//         elevation: 0.0,
//       ),
//       body: Column(
//         children: [
//           CategorySelector(),
//           // Expanded(
//           //   //to expand the column to the bottom
//           //   child: Container(
//           //     decoration: BoxDecoration(
//           //         color: Colors.amber[50],
//           //         borderRadius: BorderRadius.only(
//           //           topLeft: Radius.circular(30.0),
//           //           topRight: Radius.circular(30.0),
//           //         )),
//           //   ),
//           // ),

//           RecentChats(),
//         ],
//       ),
//     );
//   }
// }
