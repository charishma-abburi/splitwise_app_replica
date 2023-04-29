// import 'package:flutter/material.dart';

// class SplitwiseAppOpenAnimation extends StatefulWidget {
//   @override
//   _SplitwiseAppOpenAnimationState createState() =>
//       _SplitwiseAppOpenAnimationState();
// }

// class _SplitwiseAppOpenAnimationState extends State<SplitwiseAppOpenAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 2));
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _animation.value,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/logo1.jpeg',
//                     width: 500,
//                     height: 500,
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   Text(
//                     'Splitwise',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
class SplitwiseAppOpenAnimation extends StatefulWidget {
  @override
  _SplitwiseAppOpenAnimationState createState() =>
      _SplitwiseAppOpenAnimationState();
}
class _SplitwiseAppOpenAnimationState extends State<SplitwiseAppOpenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    _animation.addListener(_onAnimationEnd); // Add listener here
  }

  void _onAnimationEnd() {
    if (_animation.status == AnimationStatus.completed) {
      Navigator.pushReplacementNamed(context, '/home'); // Move to home screen
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo1.jpeg',
                    width: 500,
                    height: 500,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Splitwise',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
