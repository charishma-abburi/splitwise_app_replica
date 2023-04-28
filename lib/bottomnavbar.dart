import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomNavBar({required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.group,
          color: Colors.black,),
          label: "Groups",
          //backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people,
          color:Colors.black),
          label: "Friends",
          //backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timeline,
          color:Colors.black,),
          label: "Activity",
         // backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle,
          color:Colors.black),
          label: "Account",
         // backgroundColor: Colors.black
        ),
        
      ],
        selectedItemColor: Colors.green, // This sets the color of the selected item icon and text
  unselectedItemColor: Color.fromARGB(255, 26, 25, 25), // This sets the color of the unselected item icon and text
  selectedLabelStyle: const TextStyle(
    color: Colors.green, // This sets the color of the selected item text
  ),
  unselectedLabelStyle: const TextStyle(
    color: Color.fromARGB(255, 19, 19, 19), // This sets the color of the unselected item text
  ),
 
    );
  }
}
