import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final _fullNameFocusNode = FocusNode();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  // bool _isProcessing = false;
  String _selectedCountryCode = '+1';
  final List<String> _countryCodes = [
    '+1',
    '+91',
    '+44',
    '+86',
    '+81',
    '+55',
    '+61',
    '+64',
    '+81',
  ];
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      print("hi");
      print(email);
      print(password);
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _requestfullNameFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_fullNameFocusNode);
    });
  }

  void _requestEmailFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  void _requestPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    });
  }

  void _requestphoneFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_phoneFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext _context = context;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Sign Up'),
        backgroundColor: const Color.fromRGBO(76, 187, 155, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _fullNameController,
                focusNode: _fullNameFocusNode,
                onTap: _requestfullNameFocus,
                // validator: (value) => Validator.validateName(
                //         name: value,
                //       ),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(76, 187, 155, 1),
                      width: 2,
                    ),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    // borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    color: _fullNameFocusNode.hasFocus
                        ? const Color.fromRGBO(76, 187, 155, 1)
                        : Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
               TextField(
              controller: _emailController,
              obscureText: true,
              focusNode: _emailFocusNode,
              onTap: _requestEmailFocus,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(76, 187, 155, 1),
                    width: 2,
                  ),
                ),
                labelText: 'Email address',
                labelStyle: TextStyle(
                  color: _emailFocusNode.hasFocus
                      ? const Color.fromRGBO(76, 187, 155, 1)
                      : Colors.black54,
                ),
              ),
            ),
              const SizedBox(height: 16.0),
               TextField(
              controller: _passwordController,
              obscureText: true,
              focusNode: _passwordFocusNode,
              onTap: _requestPasswordFocus,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(76, 187, 155, 1),
                    width: 2,
                  ),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: _passwordFocusNode.hasFocus
                      ? const Color.fromRGBO(76, 187, 155, 1)
                      : Colors.black54,
                ),
              ),
            ),
              const SizedBox(height: 16.0),
              const Text(
                'Phone Number (Optional)',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: DropdownButton(
                      value: _selectedCountryCode,
                      items: _countryCodes.map((countryCode) {
                        return DropdownMenuItem(
                          value: countryCode,
                          child: Text(countryCode),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountryCode = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: _phoneFocusNode,
                      onTap: _requestphoneFocus,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(76, 187, 155, 1),
                            width: 2,
                          ),
                        ),
                        labelText: 'phone number',
                        labelStyle: TextStyle(
                          color: _phoneFocusNode.hasFocus
                              ? const Color.fromRGBO(76, 187, 155, 1)
                              : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // if (_emailController.text.trim().isEmpty ||
                    //     _passwordController.text.trim().isEmpty) {
                    //   // Show an error message or do something else to notify the user that the fields are empty
                    //   print('Email and password fields cannot be empty');
                    //   return;
                    // }

                    try {
                      await createUserWithEmailAndPassword(
                          _emailController.text, _passwordController.text);
                      final User? user = _auth.currentUser;
                      if (user != null) {
                        print(
                            'User: ${user.displayName}'); // Print user name if user is not null
                        print(_emailController.text.trim());
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(_context).pushNamed('/home');
                      }
                      // Successfully signed up user, do something here...
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: Color.fromRGBO(76, 187, 155, 1),
                    minimumSize: Size(100, 45),
                  ),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
