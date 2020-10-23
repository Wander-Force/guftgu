import 'users.dart';

class Message {
  final String sender;
  final String time;
  final String text;
  //final bool isLiked;
  //final bool unread; //won't need later

  Message({
    this.sender,
    this.time,
    this.text,
    //this.isLiked,
    //this.unread,
  });
}

// final User currentUser = User(
//   id: 0,
//   name: 'Current User',
//   imageUrl: 'assets/images/person_110935.png',
// );

// final User john = User(
//   id: 1,
//   name: 'John',
//   imageUrl: 'assets/images/person_110935.png',
// );

// final User jini = User(
//   id: 2,
//   name: 'Jini',
//   imageUrl: 'assets/images/person_110935.png',
// );

// final User ruchi = User(
//   id: 3,
//   name: 'Ruchi',
//   imageUrl: 'assets/images/person_110935.png',
// );

// final User devansh = User(
//   id: 4,
//   name: 'Devansh',
//   imageUrl: 'assets/images/person_110935.png',
// );

// final User devika = User(
//   id: 5,
//   name: 'Devika',
//   imageUrl: 'assets/images/person_110935.png',
// );

// final User prachi = User(
//   id: 6,
//   name: 'Prachi',
//   imageUrl: 'assets/images/person_110935.png',
// );

// // -------- FAVORITE CONTACTS-------->
// List<User> favorites = [jini, ruchi, devansh];

// //----------- EXAMPLE CHATS --------->

// List<Message> chats = [
//   Message(
//     sender: devika,
//     time: '5:30 PM',
//     text: 'Hey! How\'s it going?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: ruchi,
//     time: '6:30 PM',
//     text: 'Call me when you get back home',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: john,
//     time: '5:52 PM',
//     text: 'Call',
//     isLiked: false,
//     unread: false,
//   ),
//   Message(
//     sender: jini,
//     time: '5:30 PM',
//     text: 'Hey! How\'s it going?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: prachi,
//     time: '5:30 PM',
//     text: 'Hey! How\'s it going?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: devansh,
//     time: '1:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
// ];

// // EXAMPLE MESSAGES IN CHAT SCREEN
// List<Message> messages = [
//   Message(
//     sender: jini,
//     time: '5:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: true,
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '4:30 PM',
//     text: 'Just walked my doge. She was super duper cute. The best pupper!!',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: jini,
//     time: '3:45 PM',
//     text: 'How\'s the doggo?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: jini,
//     time: '3:15 PM',
//     text: 'All the food',
//     isLiked: true,
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '2:30 PM',
//     text: 'Nice! What kind of food did you eat?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: jini,
//     time: '2:00 PM',
//     text: 'I ate so much food today.',
//     isLiked: false,
//     unread: true,
//   ),
// ];
