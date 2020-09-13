
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/components/RoundedButton.dart';
import 'package:flutter_firebase_chat/screen/chat_screen.dart';
import 'package:flutter_firebase_chat/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {

  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  bool _showSpinner = false;

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;

                },
                decoration: kTextFieldInputDecoration
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  _password = value;

                },
                decoration: kTextFieldInputDecoration.copyWith(hintText:  'Enter Your Password')
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                title: 'Register',
                onPressed: () async{
                  setState(() {
                    _showSpinner = true;
                  });
                    try {
                      final newUser = await registerUser(_email, _password);
                      if (newUser != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    } catch (e) {
                     print(e);
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future registerUser(String email, String password){
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}