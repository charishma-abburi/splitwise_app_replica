import 'package:splitwise_app_replica/constants.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 40, 0.0, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Account",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 0.5, color: Colors.grey))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              "assets/pf.png",
                              height: 80.0,
                            ),
                          ),
                          Column(
                            children: [
                              Text(username.toString(),
                                  style: const TextStyle(fontSize: 20.0)),
                              Text(email.toString(),
                                  style: const TextStyle(fontSize: 15.0)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      // style: ButtonStyle(backgroundColor:Color.fromRGBO(76, 187, 155, 1), ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(76, 187, 155, 1),
                        ),
                      ),
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
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color.fromRGBO(76, 187, 155, 1),
                                    ),
                                  ),
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
                                  child: const Text('Cancel',
                                  style: TextStyle(
                                    color:  Color.fromRGBO(76, 187, 155, 1),
                                  ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Set up UPI ID',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      // width: double.infinity,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        label: const Text('Logout',
                            style: TextStyle(fontSize: 20, color: colorTheme)),
                        icon: const Icon(
                          Icons.logout,
                          color: colorTheme,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
