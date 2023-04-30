import 'package:splitwise_app_replica/constants.dart';
import 'package:splitwise_app_replica/services/database.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  static const id = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String phone = '';
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                              "assets/logos/sw-wide.png",
                            height: 50.0,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          contentPadding: EdgeInsets.only(
                            bottom: 0.0
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: colorTheme,
                              width: 2.0
                            )
                          )
                        ),
                        validator: (val) {
                          if (val == null) {
                            return "Enter an non null Name";
                          } else {
                            return val.isEmpty ? "Enter a Name" : null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Your email address',
                            contentPadding: EdgeInsets.only(
                                bottom: 0.0
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorTheme,
                                  width: 2.0
                                )
                            )
                        ),
                        validator: (val) {
                          if (val == null) {
                            return "Enter an non null email";
                          } else {
                            return val.isEmpty ? "Enter an email" : null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Your Password',
                            suffixIcon: IconButton(
                              icon: _obscureText ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                              ) : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.only(
                                bottom: 0.0
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: colorTheme,
                                    width: 2.0
                                )
                            )
                        ),
                        validator: (val) {
                          if (val == null) {
                            return "Enter a non null password of minimum 6 chars";
                          } else {
                            return val.length < 6
                                ? "Enter a password of minimum 6 chars"
                                : null;
                          }
                        },
                        obscureText: _obscureText,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 200.0,
                            child: TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                  labelText: 'Phone # (optional)',
                                  contentPadding: EdgeInsets.only(
                                      bottom: 0.0
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorTheme,
                                          width: 2.0
                                      )
                                  )
                              ),

                              onChanged: (val) {
                                setState(() {
                                  phone = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 80.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(173, 173, 173, 1),
                                width: 1.0
                              ),
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            width: 120.0,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Back",
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(173, 173, 173, 1),
                                    width: 1.0
                                ),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            width: 120.0,
                            height: 50.0,
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  dynamic result = await _auth
                                      .registerWithEmailAndPassword(email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Enter a valid email';
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    await _db.CreateUser(
                                        result.uid, email, name);
                                    setState(() {
                                      error = '';
                                    });
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: colorTheme,

                              ),
                              child: const Text(
                                "Done",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],

                      ),
                      Container(
                        height: 40.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      );
  }

}
