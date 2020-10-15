import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

var authc = FirebaseAuth.instance;
//var fireStore = FirebaseFirestore.instance;

class _MyLoginState extends State<MyLogin> {
  final formKey = new GlobalKey<FormState>();

  String email;
  String password;
  bool spin = false;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('*****VALIDATED*****');
      return true;
    }
    return false;
  }

  //-------------------------------------------->
  //                Validate, Store, Navigate
  //-------------------------------------------->

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        UserCredential userCredential;
        try {
          userCredential = await authc.signInWithEmailAndPassword(
              email: email, password: password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user not found') {
            print(
                'No user such found for the email. Create an accout or try another email');
          } else if (e.code == 'wrong password') {
            print('Wrong Password, Try Again.');
          }
        }
        User user = userCredential.user;
        print('Signed In : ${user.uid}');
        if (user != null) {
          Navigator.pushNamed(context, "chat");
        }
      } catch (e) {
        print('ERROR: $e');
      }
    }
  }

  // void userAuthentication() async {
  //   try {
  //     var userSignIn = await authc.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     print("****** USER ***** $userSignIn");

  //     if (userSignIn != null) {
  //       Navigator.pushNamed(context, "chat");
  //       setState(() {
  //         spin = false;
  //       });
  //     }
  //   } catch (e) {
  //     print("**** ERROR **** $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 300,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildInputs() + buildButtons(),
              ),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: "Email"),
        validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        onSaved: (value) => email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "Password"),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
        onSaved: (value) => password = value,
      )
    ];
  }

  List<Widget> buildButtons() {
    return [
      Material(
        color: Colors.amberAccent,
        elevation: 10,
        child: MaterialButton(
            minWidth: 200,
            height: 40,
            child: Text('Login'),
            onPressed: () async {
              setState(() {
                spin = true;
                validateAndSubmit();
              });
            }),
      )
    ];
  }
}
