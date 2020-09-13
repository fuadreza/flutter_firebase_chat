import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/screen/chat_screen.dart';
import 'package:flutter_firebase_chat/screen/login_screen.dart';
import 'package:flutter_firebase_chat/screen/registration_screen.dart';
import 'package:flutter_firebase_chat/screen/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FireChat());
}

class FireChat extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    // print(_auth.currentUser.email);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: isLoggedIn() ? ChatScreen.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
