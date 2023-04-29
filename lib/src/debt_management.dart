import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DebtManagementScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debt Management'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('debts').snapshots(),
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
              final debtor = debt['debtor'];
              final creditor = debt['creditor'];
              final amount = debt['amount'];
              final isPaid = debt['isPaid'];

              return ListTile(
                title: Text('$debtor owes $creditor $amount'),
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
    debtRef.update({'isPaid': true});
  }
}

class AddDebtScreen extends StatefulWidget {
  @override
  _AddDebtScreenState createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends State<AddDebtScreen> {
  final TextEditingController _debtorController = TextEditingController();
  final TextEditingController _creditorController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addDebt() {
    final debtor = _debtorController.text;
    final creditor = _creditorController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (debtor.isNotEmpty && creditor.isNotEmpty && amount > 0) {
      FirebaseFirestore.instance.collection('debts').add({
        'debtor': debtor,
        'creditor': creditor,
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
              controller: _debtorController,
              decoration: InputDecoration(hintText: 'Debtor'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _creditorController,
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