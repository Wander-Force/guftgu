import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class MySignUp extends StatefulWidget {
  @override
  _MySignUpState createState() => _MySignUpState();
}

var authc = FirebaseAuth.instance;
var fireStore = FirebaseFirestore.instance;

class _MySignUpState extends State<MySignUp> {
  final formKey = GlobalKey<FormState>();

  String email;
  String password;
  String name;
  bool spin = false;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('***** VALIDATED*****');
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        //UserCredential userCredential;
        // try {
        //   userCredential = await authc.createUserWithEmailAndPassword(
        //       email: email, password: password);
        // } on FirebaseAuthException catch (e) {
        //   print('***** Authentication Error ***** : $e');
        // }

        dynamic result = await authc.createUserWithEmailAndPassword(
            email: email, password: password);
        User user = result.user;
        fireStore.collection("users").add({
          "name": name,
          "email": email,
        }).then((value) => null);

        print('Signed Up : ${user.uid}');
        if (user != null) {
          Navigator.pushNamed(context, "login");
        }
      } catch (e) {
        print('Error in Sign up: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[50],
      ),
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 300,
            child: Center(
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildInputs() + buildSubmitButtons(),
                  )),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'name'),
        validator: (value) => value.isEmpty ? 'please enter your name' : null,
        onSaved: (value) => name = value,
      ),
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: "email"),
        validator: (value) =>
            value.isEmpty ? 'Email cannot be left empty' : null,
        onSaved: (value) => email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'password'),
        obscureText: true,
        validator: (value) =>
            value.isEmpty ? 'please enter your password' : null,
        onSaved: (value) => name = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    return [
      Material(
        color: Colors.amberAccent,
        elevation: 10,
        child: MaterialButton(
            minWidth: 200,
            height: 40,
            child: Text('Sign Up'),
            onPressed: () async {
              setState(() {
                spin = true;
                validateAndSubmit();
              });
            }),
      ),
      FlatButton(
          child: Text("alredy an account? Login"),
          onPressed: () async {
            setState(() {
              Navigator.pushNamed(context, "login");
            });
          }),
    ];
  }
}
