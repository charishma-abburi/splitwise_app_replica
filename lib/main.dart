import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/login.dart';
import 'package:splitwise_app_replica/signup.dart';

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
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => SignUpScreen(),
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
                backgroundColor: Color.fromRGBO(76, 187, 155, 1),
                minimumSize: Size(350, 50),
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
                backgroundColor: Color.fromARGB(225, 255, 255, 255),
                minimumSize: Size(350, 50),
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
                backgroundColor: Color.fromARGB(225, 255, 255, 255),
                minimumSize: Size(350, 50),
              ),
              onPressed: () {
                // TODO: Implement login functionality
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
