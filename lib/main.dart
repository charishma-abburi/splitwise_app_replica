// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/animation.dart';
import 'package:splitwise_app_replica/group_page.dart';
import 'package:splitwise_app_replica/login.dart';
import 'package:splitwise_app_replica/signup.dart';
import 'package:splitwise_app_replica/home.dart';
import 'package:splitwise_app_replica/homepage.dart';
import 'package:splitwise_app_replica/services/auth.dart';
import 'package:splitwise_app_replica/services/database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplitwiseAppOpenAnimation(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/homepage': (context) => const HomePage(),
        '/groupscreen': (context) => GroupScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: const Color.fromRGBO(76, 187, 155, 1),
                minimumSize: const Size(350, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
                // TODO: Implement login functionality
              },
              child: const Text('Sign up'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(225, 255, 255, 255),
                minimumSize: const Size(350, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
                // TODO: Implement login functionality
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(225, 255, 255, 255),
                minimumSize: const Size(350, 50),
              ),
              onPressed: () async {
                // TODO: Implement login functionality
                try {
                  dynamic result = await _auth.googleLogIn();
                  String phonenum = "";
                  String phonecode = "";
                  print("hi");
                  print(result.uid);
                  print(result.name);
                  await _db.CreateUser(result.uid, result.email,
                      result.password, result.name, phonenum, phonecode);
                  if (result == null) {
                    print("ERROR!!");
                    print("hii");
                  } else {
                    print("hiii");
                    Navigator.of(context).pushNamed('/homepage');

                    print("GR* SUCSES");
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text(
                'Sign in with Google',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
