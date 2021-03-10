import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/component/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
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
                      hintText: 'Enter your password'),),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                title: 'Log In',
                colour: Colors.lightBlueAccent,
                onpressed: () async{
                  setState(() {
                    _showspine=true;
                  });
                  try{
                    final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(user!=null)
                    {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      _showspine=false;
                    });
                  }

                  catch(e)
                  {
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
