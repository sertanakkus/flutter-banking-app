import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_validator/email_validator.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context,
      {required String username, required String email, required String password, required String phone}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await registerUser(user: userCredential, username: username, email: email, password: password, phone: phone);
        navigator.pushNamed('/home', arguments: userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> signIn(BuildContext context,
      {required String email, required String username, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').where('username', isEqualTo: username).limit(1).get();

      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: _isEmail(email) ? email : snapshot.docs.first['email'], password: password);
      if (userCredential.user != null) {
        // print(userCredential.user!.uid);
        final userDoc = await userCollection.doc(userCredential.user!.uid).get().then((value) => value.data());

        navigator.pushNamed('/home', arguments: userDoc?['username']);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  Future<void> registerUser(
      {required UserCredential user,
      required String username,
      required String email,
      required String password,
      required String phone}) async {
    await userCollection
        .doc(user.user!.uid)
        .set({"email": email, "username": username, "password": password, "phone": phone});
  }

  bool _isEmail(String email) {
    bool isValid = EmailValidator.validate(email);
    return isValid;
  }
}
