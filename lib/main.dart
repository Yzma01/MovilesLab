import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/map/user_map.dart';
import 'package:uber/users/forgot_password.dart';
import 'package:uber/users/sign_up.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' App Multiscreen ',
      initialRoute: '/ ',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context)=> SignUpScreen(),
        '/home ': (context) => HomeScreen(),
        '/forgot-password': (context)=>ForgotPasswordScreen(),
        '/map' : (context) => UserMap(),
        '/profile ': (context) => ProfileScreen(),
      },
    );
  }
}
