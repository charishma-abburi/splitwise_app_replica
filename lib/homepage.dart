
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/animation.dart';
import 'package:splitwise_app_replica/login.dart';
import 'package:splitwise_app_replica/signup.dart';
import 'package:splitwise_app_replica/expenses.dart';
import 'package:splitwise_app_replica/home.dart';
import 'package:splitwise_app_replica/account.dart';

import 'bottomnavbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text("HomePage"),
       backgroundColor: Colors.white,
     
   actions:[ IconButton(
      icon: Icon(Icons.group_add,
      color:Colors.black),
      onPressed: () {
       
      },
    ),
   ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen to start a new group.
              },
              style:ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text("+ Start a new group",
              style:TextStyle(color:Colors.green),
            
              ),
            ),
           
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewExpenseScreen()),
          );
        },
        label:Text("Add Expense"),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

   if (index == 3) {
    // Handle Account tab tap event here
    // For example, navigate to the account screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountScreen()),
    );
  }

  }
}

