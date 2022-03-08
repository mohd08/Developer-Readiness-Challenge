import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Authorization/auth_helper.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  String? title;

  @override
  Widget build(BuildContext context) {

    return CupertinoAlertDialog(
      title: Text('Add in token', textAlign: TextAlign.center, style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
      content: 
      Center(
        child: Column(
          children: [
            Text('Enter the BeRad app API token for "johndoe@gmail.com".', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (_val) {
                      title = _val;
                    },
                    decoration: 
                    InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter token',
                      filled: true,
                      fillColor: Color(0xFFF4F4F4),
                    ),
                  ),
                ],
              ),
            ),
          ]
        )
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel', style: TextStyle(fontSize: 17)),
        ),
        TextButton(
          onPressed: () => add(),
          child: const Text('Verify', style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }
  
  void add() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes')
        .add({
      'token': title,
      'created': DateTime.now(),
    });
    // save to db
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Data Added Successfully'),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    AuthHelper().logOut();
  }
}
