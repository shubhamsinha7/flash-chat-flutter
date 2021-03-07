import 'package:flash_chat/component/roundedbutton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 150.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 38.0,
            ),
            TextField(
              onChanged: (value) {
                email=value;
              },
              decoration:
                  kTextFieldDecuration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                password=value;
              },
              decoration: kTextFieldDecuration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 15.0,
            ),
            RoundButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onpressed: () {
                print(email);
                print(password);
              },
            )
          ],
        ),
      ),
    );
  }
}
