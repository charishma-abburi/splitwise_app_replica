import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splitwise_app_replica/services/database.dart';

class AddContribution extends StatefulWidget {
  const AddContribution({Key? key, required this.group}) : super(key: key);
  final Map<String, dynamic> group;

  @override
  State<AddContribution> createState() => _AddContributionState();
}

class _AddContributionState extends State<AddContribution> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> group = <String, dynamic>{};

  // initial values of the friend as empty map
  @override
  void initState() {
    super.initState();
    group.addAll(widget.group);
  }
  String desc = "";
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contribution'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            // shift 10 unit left
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                _formKey.currentState!.save();
                Navigator.pop(context, group);
                final uid = FirebaseAuth.instance.currentUser!.uid;
                DatabaseService().addContribution(uid, group, amount);
              }
            },
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Row(
                    children: [
                      const Text('Group : ', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Container(
                        // make rounded
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.greenAccent,
                            width: 1,
                          ),
                        ),
                        child: Text(group['name'],
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                      ),
                    ],
                  )),
            ]),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 40, 20),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.note_add,
                        size: 24.0,
                        semanticLabel: 'Description icon',
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        onChanged: (String value) { setState((){desc = value;}); },
                        decoration: const InputDecoration(
                          hintText: 'Enter a description',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 40, 20),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.currency_rupee,
                        size: 24.0,
                        semanticLabel: 'Rupee icon',
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter amount',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.parse(value) == 0) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                        onChanged: (val){
                          setState(() {
                            amount =  int.parse(val);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
              children: [
                const Text(
                  "Paid by",
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: DropdownButtonFormField(
                    items: ["Me", "You", "Both"]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                     // labelText: "Money Paid By",
                    ),
                    onChanged: (String? value) {},
                  ),
                ),
                const SizedBox(width: 7),
                const Text(
                  "Split",
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: DropdownButtonFormField(
                    items: ["Equally", "Manually", "By percentage"]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                    //  labelText: "Split",
                    ),
                    onChanged: (String? value) {},
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ]),
    );
  }
}
