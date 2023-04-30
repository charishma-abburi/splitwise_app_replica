import 'package:splitwise_app_replica/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/services/auth.dart';
import 'package:splitwise_app_replica/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  String upiID = "";
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  String? username = FirebaseAuth.instance.currentUser?.displayName;
  String? email = FirebaseAuth.instance.currentUser?.email;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Column(
          children: [
            Center(
              child: Text(username.toString(), style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('Email: $email', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Set up UPI ID'),
                        content: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter your UPI ID',
                          ),
                          onChanged: (value) {
                            upiID = value;
                            // Store the entered UPI ID in a local variable or state variable
                          },
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              // Save the entered UPI ID to the Firestore database
                              await _db.addUPI(uid, upiID);
                              Navigator.pop(context);
                            },
                            child: const Text('Save'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child:
                    const Text('Set up UPI ID', style: TextStyle(fontSize: 24)),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: const Text('Logout', style: TextStyle(fontSize: 24)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
