
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/Screens/Animations/animation.dart';
import 'package:splitwise_app_replica/Screens/Authentication/login.dart';
import 'package:splitwise_app_replica/Screens/Authentication/signup.dart';
import 'package:splitwise_app_replica/Screens/Expenses/expenses.dart';
import 'package:splitwise_app_replica/home.dart';
import 'package:splitwise_app_replica/Screens/Authentication/account.dart';
import 'package:splitwise_app_replica/Screens/GroupScreens/group_page.dart';


import '../../bottomnavbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  int oweAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("HomePage"),
        backgroundColor: Colors.white,
     
        actions:[ IconButton(
          icon: Icon(
            Icons.group_add,
            color:Colors.black
          ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Overall you owe "),
                Text(
                  this.oweAmount.toString(),
                  style: TextStyle(
                    color: Colors.amber
                  ),
                )
              ],
            )
           
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

    if (index == 0) {
    // Handle Account tab tap event here
    // For example, navigate to the account screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GroupScreen()),
    );
  }

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

