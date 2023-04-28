import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Logger _logger = Logger('my_app_logger');

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
        print("hi");
      print(email);
      print(password);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splitwise Login'),
        backgroundColor: const Color.fromRGBO(76, 187, 155, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                 // final UserCredential userCredential =
                      await signInWithEmailAndPassword(
                     _emailController.text,
                    _passwordController.text,
                  );
                  final User? user = _auth.currentUser;
                  if (user != null) {
                      print(
                            'User: ${user.displayName}');
                    print(_emailController.text);
                    await FirebaseAuth.instance.signOut();
                    Fluttertoast.showToast(
                        msg: "Login successful",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    Navigator.of(context).pushNamed('/');
                    // Navigate to home screen or perform any action after successful login
                    // print("hi");
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                    Fluttertoast.showToast(
                        msg: "No user found for that email.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white);
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    Fluttertoast.showToast(
                        msg: "Wrong password provided for that user.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white);
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
              child: const Text('Log in'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Implement forgot password functionality
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color.fromRGBO(76, 187, 155, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
