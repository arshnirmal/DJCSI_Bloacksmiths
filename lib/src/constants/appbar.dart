import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBarTop {
  static AppBar appBar(Widget title) {
    return AppBar(
      title: title,
      backgroundColor: const Color(0xfff2eae2),
      actions: [
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) => Text(snapshot.hasData
              ? snapshot.data!['coffee_beans'].toString()
              : ""),
        ),
        const Icon(Icons.wallet_giftcard),
      ],
    );
  }
}
