import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_twitter/app/infrastructures/contracts/base_controller.dart';
import 'package:simple_twitter/app/ui/pages/pages.dart';

class HomeController extends BaseController {

  TextEditingController _userNameInput = new TextEditingController();
  TextEditingController _tweetInput = new TextEditingController();

  bool isDisposed = false;

  TextEditingController get userNameInput => _userNameInput;
  TextEditingController get tweetInput => _tweetInput;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AsyncSnapshot<QuerySnapshot> snapshot;
  DateTime tweetTime;
  DocumentSnapshot document;

  CollectionReference tweets = FirebaseFirestore.instance.collection('tweets');
  List<QueryDocumentSnapshot<Object>> data = [];

  HomeController() : super() {
    //
  }

  @override
  void initListeners() async {
    super.initListeners();
  }


  void submitTweet() {
    tweets.add({
      'username': _firebaseAuth.currentUser.email,
      'updatedat': DateTime.now(),
      'tweets': tweetInput.text
    });
    tweetInput.clear();
    Navigator.of(getContext(), rootNavigator: true).pop();
  }

  void deleteTweet(AsyncSnapshot<QuerySnapshot> snapshot, int index) async {
    DocumentSnapshot ds = snapshot.data.docs[index];
    await tweets.doc(ds.id).delete();
    refreshUI();
  }

  void openEditDialog(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    DocumentSnapshot ds = snapshot.data.docs[index];
    tweetInput.text = ds['tweets'];
    showDialog(
        context: getContext(),
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit Tweet"),
            actions: [
              TextButton(
                  onPressed: () {
                    tweets.doc(ds.id).set({
                      'username': _firebaseAuth.currentUser.email,
                      'updatedat': DateTime.now(),
                      'tweets': tweetInput.text
                    });
                    tweetInput.clear();
                    Navigator.of(getContext(), rootNavigator: true).pop();
                  },
                  child: Text("Send"))
            ],
            content: TextFormField(
              controller: tweetInput,
              maxLength: 280,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
            ),
          );
        });
  }

  void openDeleteDialog() {
    showDialog(
        context: getContext(),
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Tweet Something"),
            actions: [TextButton(onPressed: submitTweet, child: Text("Send"))],
            content: TextFormField(
              controller: tweetInput,
              maxLength: 280,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
            ),
          );
        });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print("SUCCESS SIGN OUT");
    Navigator.pushReplacementNamed(getContext(), Pages.login);
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}

class ErrorMessage {
  String userId = '';
  bool isValid() {
    return userId.isEmpty ? true : false;
  }
}
