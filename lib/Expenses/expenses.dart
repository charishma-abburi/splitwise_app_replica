// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class NewExpenseScreen extends StatelessWidget {
//   int count = 0;
//   final _descController = TextEditingController();
//   final _amtController = TextEditingController();
//   NewExpenseScreen({super.key, required this.count});
//   @override
//   void dispose() {
//     _descController.dispose();
//     _amtController.dispose();
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
//                     controller: _descController,
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
//                     controller: _amtController,
//                     decoration: InputDecoration(
//                       labelText: "Amount",
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             // Row(
//             //   children: [
//             //     Text(
//             //       "Paid by",
//             //       style: TextStyle(fontSize: 10),
//             //     ),
//             //     SizedBox(width: 3),
//             //     Expanded(
//             //       child: DropdownButtonFormField(
//             //         items: ["Me", "You", "Both"]
//             //             .map((category) => DropdownMenuItem(
//             //                   value: category,
//             //                   child: Text(category),
//             //                 ))
//             //             .toList(),
//             //         decoration: InputDecoration(
//             //          // labelText: "Money Paid By",
//             //         ),
//             //         onChanged: (String? value) {},
//             //       ),
//             //     ),
//             //     SizedBox(width: 10),
//             //     Text(
//             //       "Split",
//             //       style: TextStyle(fontSize: 10),
//             //     ),
//             //     SizedBox(width: 3),
//             //     Expanded(
//             //       child: DropdownButtonFormField(
//             //         items: ["Equally", "Manually", "By percentage"]
//             //             .map((category) => DropdownMenuItem(
//             //                   value: category,
//             //                   child: Text(category),
//             //                 ))
//             //             .toList(),
//             //         decoration: InputDecoration(
//             //         //  labelText: "Split",
//             //         ),
//             //         onChanged: (String? value) {},
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             SizedBox(height: 16),
//             ElevatedButton(
//                 onPressed: () async {
//                   print(count);
//                   Navigator.pop(context, {
//                     'count': count + 1,
//                     'desc': _descController.text.trim(),
//                     'amount': _amtController.text.trim()
//                   });
//                 },
//                 child: Text("Add Expense"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ExpenseScreen extends StatelessWidget {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense Management'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: firestore.collection('expenses').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final debts = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: debts.length,
//             itemBuilder: (context, index) {
//               final debt = debts[index];
//               final desc = debt['desc'];
//               final date = debt['date'];
//               final amount = debt['amount'];
//               final isPaid = debt['isPaid'];

//               return ListTile(
//                 title: Text('$desc You have added expense owes $date $amount'),
//                 subtitle: isPaid ? Text('Paid') : Text('Not Paid'),
//                 trailing: isPaid
//                     ? null
//                     : ElevatedButton(
//                         onPressed: () => _settleDebt(debt.reference),
//                         child: Text('Settle'),
//                       ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _addExpense(context),
//        // child: Icon(Icons.add),
//          icon: const ImageIcon(
//           AssetImage("assets/expenseIcon2.jpg"),
//         ),
//         label: const Text("Add Expense"),
//         backgroundColor:  const Color.fromRGBO(76, 187, 155, 1),
//       ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }

//   void _addExpense(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddExpenseScreen()),
//     );
//   }

//   void _settleDebt(DocumentReference debtRef) {
//     debtRef.update({'isPaid': true});
//   }
// }

// class AddExpenseScreen extends StatefulWidget {
//   @override
//   _AddExpenseScreenState createState() => _AddExpenseScreenState();
// }

// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   final TextEditingController _descController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();

//   void _addExpense() {
//     final desc = _descController.text;
//     final date = _dateController.text;
//     final amount = double.tryParse(_amountController.text) ?? 0.0;

//     if (desc.isNotEmpty && date.isNotEmpty && amount > 0) {
//       FirebaseFirestore.instance.collection('debts').add({
//         'desc': desc,
//         'date': date,
//         'amount': amount,
//         'isPaid': false,
//       });

//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Expense'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _descController,
//               decoration: InputDecoration(hintText: 'desc'),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: _dateController,
//               decoration: InputDecoration(hintText: 'date'),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(hintText: 'Amount'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _addExpense,
//               child: Text('Add Debt'),
//             ),
//           ],
//     ),
//   ),
// );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splitwise_app_replica/Expenses/upiPayment.dart';


class ExpenseManagementScreen extends StatefulWidget {
  @override
  State<ExpenseManagementScreen> createState() => _ExpenseManagementScreenState();
}

class _ExpenseManagementScreenState extends State<ExpenseManagementScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Management'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('expenses').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final debts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: debts.length,
            itemBuilder: (context, index) {
              final debt = debts[index];
              final desc = debt['desc'];
              final date = debt['date'];
              final amount = debt['amount'];
              final isPaid = debt['isPaid'];

              return ListTile(
                title: Text('$desc owes $date $amount'),
                subtitle: isPaid ? Text('Paid') : Text('Not Paid'),
                trailing: isPaid
                    ? null
                    : ElevatedButton(
                        onPressed: () => _settleDebt(debt.reference),
                        child: Text('Settle'),
                      ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addDebt(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addDebt(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDebtScreen()),
    );
  }

  void _settleDebt(DocumentReference debtRef) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UPIpayment()),
    );
   
    debtRef.update({'isPaid': true});
  }
}

class AddDebtScreen extends StatefulWidget {
  @override
  _AddDebtScreenState createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends State<AddDebtScreen> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addDebt() {
    final desc = _descController.text;
    final date = _dateController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (desc.isNotEmpty && date.isNotEmpty && amount > 0) {
      FirebaseFirestore.instance.collection('expenses').add({
        'desc': desc,
        'date': date,
        'amount': amount,
        'isPaid': false,
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Debt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _descController,
              decoration: InputDecoration(hintText: 'Debtor'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(hintText: 'Creditor'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addDebt,
              child: Text('Add Debt'),
            ),
          ],
    ),
  ),
);
  }
}