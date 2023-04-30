import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewExpenseScreen extends StatelessWidget {
  int count = 0;
  final _descController = TextEditingController();
  final _amtController = TextEditingController();
  NewExpenseScreen({super.key, required this.count});
  @override
  void dispose() {
    _descController.dispose();
    _amtController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Expense",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.description),
                SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(
                      labelText: "Description",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.attach_money),
                SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    controller: _amtController,
                    decoration: InputDecoration(
                      labelText: "Amount",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text(
            //       "Paid by",
            //       style: TextStyle(fontSize: 10),
            //     ),
            //     SizedBox(width: 3),
            //     Expanded(
            //       child: DropdownButtonFormField(
            //         items: ["Me", "You", "Both"]
            //             .map((category) => DropdownMenuItem(
            //                   value: category,
            //                   child: Text(category),
            //                 ))
            //             .toList(),
            //         decoration: InputDecoration(
            //          // labelText: "Money Paid By",
            //         ),
            //         onChanged: (String? value) {},
            //       ),
            //     ),
            //     SizedBox(width: 10),
            //     Text(
            //       "Split",
            //       style: TextStyle(fontSize: 10),
            //     ),
            //     SizedBox(width: 3),
            //     Expanded(
            //       child: DropdownButtonFormField(
            //         items: ["Equally", "Manually", "By percentage"]
            //             .map((category) => DropdownMenuItem(
            //                   value: category,
            //                   child: Text(category),
            //                 ))
            //             .toList(),
            //         decoration: InputDecoration(
            //         //  labelText: "Split",
            //         ),
            //         onChanged: (String? value) {},
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  print(count);
                  Navigator.pop(context, {
                    'count': count + 1,
                    'desc': _descController.text.trim(),
                    'amount': _amtController.text.trim()
                  });
                },
                child: Text("Add Expense"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                )),
          ],
        ),
      ),
    );
  }
}

// class NewExpenseScreen extends StatefulWidget {
//   @override
//   _NewExpenseScreenState createState() => _NewExpenseScreenState();
// }

// class _NewExpenseScreenState extends State<NewExpenseScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late Stream<List<String>> _groupsStream;
//   late Stream<List<String>> _friendsStream;

//   @override
//   void initState() {
//     super.initState();
//     // Listen to changes in the "groups" collection in Firebase and update the dropdown menu accordingly
//     _groupsStream = _firestore.collection('groups').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => doc.data()['name'] as String).toList();
//     });

//     // Listen to changes in the "friends" collection in Firebase and update the dropdown menu accordingly
//     _friendsStream =
//         _firestore.collection('friends').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => doc.data()['name'] as String).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "New Expense",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Colors.black,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.description),
//                 SizedBox(width: 15),
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: "Description",
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 15),
//             Row(
//               children: [
//                 Icon(Icons.attach_money),
//                 SizedBox(width: 15),
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: "Amount",
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   "Paid by",
//                   style: TextStyle(fontSize: 10),
//                 ),
//                 SizedBox(width: 3),
//                 // Expanded(
//                 //   child: StreamBuilder<List<String>>(
//                 //     stream: _friendsStream,
//                 //     builder: (BuildContext context,
//                 //         AsyncSnapshot<List<String>> snapshot) {
//                 //       if (snapshot.hasData) {
//                 //         return DropdownButtonFormField(
//                 //           items: snapshot.data!
//                 //               .map((category) => DropdownMenuItem(
//                 //                     value: category,
//                 //                     child: Text(category),
//                 //                   ))
//                 //               .toList(),
//                 //           decoration: InputDecoration(
//                 //               // labelText: "Money Paid By",
//                 //               ),
//                 //           onChanged: (String? value) {},
//                 //         );
//                 //       } else {
//                 //         return Container();
//                 //       }
//                 //     },
//                 //   ),
//                 // ),
//                 SizedBox(width: 10),
//                 Text(
//                   "Split",
//                   style: TextStyle(fontSize: 10),
//                 ),
//                 SizedBox(width: 3),
//                 Expanded(
//                   child: StreamBuilder<List<String>>(
//                     stream: _groupsStream,
//                     builder: (BuildContext context,
//                         AsyncSnapshot<List<String>> snapshot) {
//                       if (snapshot.hasData) {
//                         return DropdownButtonFormField(
//                           items: snapshot.data!
//                               .map((category) => DropdownMenuItem(
//                                     value: category,
//                                     child: Text(category),
//                                   ))
//                               .toList(),
//                           decoration: InputDecoration(
//                               labelText: "Split",
//                               ),
//                           onChanged: (String? value) {},
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
           
//             SizedBox(height: 10),
           
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text("Save"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
