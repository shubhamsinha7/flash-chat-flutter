import 'package:flash_chat/component/roundedbutton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showspine=false;
  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showspine,
        child: Padding(
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
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
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
                obscureText: true,
                textAlign: TextAlign.center,
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
                onpressed: ()async {
                  setState(() {
                    _showspine=true;
                  });
                  try{
                    final newuser=await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(email!=null)
                      {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    setState(() {
                      _showspine=false;
                    });
                  }
                  catch(e){
                    print(e);
                  }

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
