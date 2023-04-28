import 'package:flutter/material.dart';

class NewExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Expense",
        style: TextStyle(color:Colors.black,
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
                    decoration: InputDecoration(
                      labelText: "Amount",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Paid by",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(width: 3),
                Expanded(
                  child: DropdownButtonFormField(
                    items: ["Me", "You", "Both"]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                     // labelText: "Money Paid By",
                    ),
                    onChanged: (String? value) {},
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Split",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(width: 3),
                Expanded(
                  child: DropdownButtonFormField(
                    items: ["Equally", "manuallyy", "By percentage"]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                    //  labelText: "Split",
                    ),
                    onChanged: (String? value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text("Add Expense"),
              style:ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              )
            ),
          ],
        ),
      ),
    );
  }
}
