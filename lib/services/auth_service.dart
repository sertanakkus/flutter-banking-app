import 'dart:math';

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
        await registerUser(
            user: userCredential,
            id: userCredential.user!.uid,
            username: username,
            email: email,
            password: password,
            phone: phone);
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
        // final userDoc = await userCollection.doc(userCredential.user!.uid).get().then((value) => value.data());

        navigator.pushNamed('/home', arguments: await getUserData(userCredential.user!.uid));
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

  Future<Object?> getUserData(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot.data();
  }

  Future<void> registerUser(
      {required UserCredential user,
      required String id,
      required String username,
      required String email,
      required String password,
      required String phone}) async {
    await userCollection.doc(user.user!.uid).set({
      "account_no": generateRandomNumber(),
      "cards": [],
      "email": email,
      "id": id,
      "password": password,
      "phone": phone,
      "total_balance": 0,
      "username": username
    });
  }

  Future<Map<String, dynamic>?> getCurrenUserData() async {
    String currentUserId = firebaseAuth.currentUser!.uid;
    final user = await userCollection.doc(currentUserId).get();
    return user.data();
  }

  Future<Object?> getUserDataByAccountNo(String accountNo) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').where('account_no', isEqualTo: accountNo).limit(1).get();
    Object? data = snapshot.docs.first.data();
    return data;
  }

  Future<void> updateBalance(
      {required String senderUserId, required String receiverUserId, required String amount}) async {
    final sender = userCollection.doc(senderUserId);
    final receiver = userCollection.doc(receiverUserId);

    final senderSnapshot = await sender.get();
    final receiverSnapshot = await receiver.get();

    num senderBalance = senderSnapshot.data()!['total_balance'];
    num receiverBalance = receiverSnapshot.data()!['total_balance'];

    senderBalance -= num.parse(amount);
    receiverBalance += num.parse(amount);

    await sender.update({"total_balance": senderBalance});
    await receiver.update({"total_balance": receiverBalance});

    print("Balance updated");
  }

  Future<void> addToQuickTransfer(String userId) async {
    String currentUserId = firebaseAuth.currentUser!.uid;
    final user = userCollection.doc(currentUserId);

    final userSnapshot = await user.get();
    List<dynamic> currentList = userSnapshot.data()?['quick_transfer'] ?? [];

    if (!currentList.contains(userId)) {
      currentList.add(userId);
      user.update({'quick_transfer': currentList});
      print("user $userId added to quick transfer list");
    }
  }

  Future<List<Map<String, dynamic>>> getQuickTransferList() async {
    String currentUserId = firebaseAuth.currentUser!.uid;
    final user = userCollection.doc(currentUserId);

    final userSnapshot = await user.get();

    List<dynamic> transferList = userSnapshot.data()?['quick_transfer'];

    List<Map<String, dynamic>> userLlist = [];

    for (var id in transferList) {
      var userToAdd = await getUserData(id) as Map<String, dynamic>;

      userLlist.add(userToAdd);
    }

    return userLlist;
  }

  Future<void> updateHistory(String transactionType, String otherUserId, String amount) async {
    String currentUserId = firebaseAuth.currentUser!.uid;
    final currentUser = userCollection.doc(currentUserId);
    final currentUserSnapshot = await currentUser.get();

    final otherUser = userCollection.doc(otherUserId);
    final otherUserSnapshot = await otherUser.get();

    List<dynamic> currentUserHistory = currentUserSnapshot.data()!['history'];
    List<dynamic> otherUserHistory = otherUserSnapshot.data()!['history'];

    if (transactionType == 'out') {
      currentUserHistory.add({
        'amount': num.tryParse(amount),
        'date': DateTime.now(),
        'transaction_type': transactionType,
        'user_id': otherUserId
      });

      otherUserHistory.add(
          {'amount': num.tryParse(amount), 'date': DateTime.now(), 'transaction_type': 'in', 'user_id': currentUserId});
    } else {
      currentUserHistory.add(
          {'amount': num.tryParse(amount), 'date': DateTime.now(), 'transaction_type': 'in', 'user_id': otherUserId});

      otherUserHistory.add({
        'amount': num.tryParse(amount),
        'date': DateTime.now(),
        'transaction_type': transactionType,
        'user_id': currentUserId
      });
    }

    currentUser.update({'history': currentUserHistory});
    otherUser.update({'history': otherUserHistory});
  }

  Future<List<dynamic>> getHistory() async {
    String currentUserId = firebaseAuth.currentUser!.uid;
    final currentUser = userCollection.doc(currentUserId);
    final currentUserSnapshot = await currentUser.get();

    return currentUserSnapshot.data()!['history'];
  }

  Future<bool> checkAccount(String accountNo) async {
    QuerySnapshot query = await userCollection.where('account_no', isEqualTo: accountNo).get();
    return query.docs.isEmpty ? false : true;
  }

  bool _isEmail(String email) {
    bool isValid = EmailValidator.validate(email);
    return isValid;
  }

  Future<bool> checkEmail(String email) async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
    return query.docs.isEmpty ? true : false;
  }

  Future<bool> checkUsername(String username) async {
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('users').where('username', isEqualTo: username).get();
    return query.docs.isEmpty ? true : false;
  }

  Future<bool> checkPhone(String phone) async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('phone', isEqualTo: phone).get();
    return query.docs.isEmpty ? true : false;
  }

  String generateRandomNumber() {
    Random random = Random();
    int min = 100000000;
    int max = 999999999;
    return (min + random.nextInt(max - min + 1)).toString();
  }
}
