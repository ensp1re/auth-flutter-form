import 'package:auth/screens/reset_password.dart';
import 'package:auth/screens/sign_in.dart';
import 'package:auth/screens/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(OstapukApp());
}

class OstapukApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ostapuk',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: SignInScreen(),
      routes: {
        '/sign-in': (context) => SignInScreen(),
        '/sign-up': (context) => SignUpScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
      },
      onGenerateRoute: (settings) {
        // Handling custom slide transition
        switch (settings.name) {
          case '/sign-in':
            return _buildPageRoute(SignInScreen());
          case '/sign-up':
            return _buildPageRoute(SignUpScreen());
          case '/reset-password':
            return _buildPageRoute(ResetPasswordScreen());
          default:
            return null;
        }
      },
    );
  }
  PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0); // Start from the right
        var end = Offset.zero; // End at the normal position
        var curve = Curves.easeInOut; // Smooth curve for the transition
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
