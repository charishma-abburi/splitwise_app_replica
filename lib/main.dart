// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:provider/provider.dart';
// import 'package:splitwise_app_replica/Tab_pages/Friends_List.dart';

// import 'package:splitwise_app_replica/Tab_pages/group.dart';
// import 'package:splitwise_app_replica/algorithm/settleTrans.dart';
// import 'package:splitwise_app_replica/data/kharche.dart';
// import 'package:splitwise_app_replica/data/people.dart';
// import 'package:splitwise_app_replica/screen/addBill.dart';
// import 'package:splitwise_app_replica/screen/peoplelist.dart';
// import 'package:splitwise_app_replica/provider/groupsData.dart';
// import 'package:splitwise_app_replica/screen/create_Group.dart';
// import 'package:splitwise_app_replica/screen/splitType.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'Tab_pages/card_pallete.dart';
// import 'data/groupdata.dart';
// var routes = <String, WidgetBuilder>{
//   "/createGroup": (BuildContext context) => CreateGroup(),
//   "/friend": (BuildContext context) => friend_list(),
//   "/group": (BuildContext context) => Group(),
//   "/tab": (BuildContext context) => Menu(),
//   "/addBill": (BuildContext context)=> addBill( ind: 0),

//   "/People": (BuildContext context) => peopleList(),
//   "/split":(BuildContext context) => expenseType(),
//   "/settle":(BuildContext context) => settleTrans(ind: 0),

// };
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.

//   @override
//   Widget build(BuildContext context) {

//     return MultiProvider(
//       providers:[
//         ChangeNotifierProvider.value(
//         value :GroupsData()),
//       ],
//         child: NeumorphicApp(

//           themeMode: ThemeMode.light, //or dark / system
//           darkTheme: NeumorphicThemeData(
//             baseColor: Color(0xff333333),
//             accentColor: Colors.green,
//             lightSource: LightSource.topLeft,
//             depth: 80,
//             intensity: 0.8,
//           ),
//           theme: NeumorphicThemeData(
//             baseColor: Color(0xffDDDDDD),
//             accentColor: Colors.cyan,
//             lightSource: LightSource.topLeft,
//             depth: 6,
//             intensity: 0.5,
//               textTheme:GoogleFonts.mcLarenTextTheme(
//                 Theme.of(context).textTheme,),
//             shadowLightColor: Colors.black38
//           ),
//            debugShowCheckedModeBanner: false,

//           home: Menu(),
//           routes: routes,
//         ),

//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_app_replica/animation.dart';
import 'package:splitwise_app_replica/login.dart';
import 'package:splitwise_app_replica/signup.dart';
import 'package:splitwise_app_replica/home.dart';

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


  // This widget is the root of your application.
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





