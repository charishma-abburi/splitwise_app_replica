
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/animation.dart';
import 'package:splitwise_app_replica/group_page.dart';
import 'package:splitwise_app_replica/login.dart';
import 'package:splitwise_app_replica/signup.dart';
import 'package:splitwise_app_replica/home.dart';
import 'package:splitwise_app_replica/homepage.dart';

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
        '/homepage' : (context) => const HomePage(),
        '/groupscreen' :(context) =>  GroupScreen(),
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



// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:splitwise_app_replica/models/user.dart';
// import 'package:splitwise_app_replica/src/authenticate/register.dart';
// import 'package:splitwise_app_replica/src/authenticate/signin.dart';
// import 'package:splitwise_app_replica/src/wrapper.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:splitwise_app_replica/services/auth.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);


//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<myUser?>.value(
//       value: AuthService().user,
//       initialData: null,
//       child: MaterialApp(
//         title: 'Campus Splitwise',
//         theme: ThemeData(
//             brightness: Brightness.dark
//         ),
//         home: Wrapper(),
//         debugShowCheckedModeBanner: false,
//         onGenerateRoute: RouteMaker.generateRoute,
//       ),

//     );
//   }
// }

// class RouteMaker {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//     switch (settings.name) {
//       case Register.id:
//         return MaterialPageRoute(builder: (context) => Register());
//       case SignIn.id:
//         return MaterialPageRoute(builder: (context) => SignIn());
//       default:
//         return _errorRoute();
//     }
//   }
//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Error'),
//         ),
//         body: const Center(
//           child: Text('ERROR'),
//         ),
//       );
//     });
//   }
// }





