import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id='chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore=Firestore.instance;
  String messageText;
  final _auth=FirebaseAuth.instance;
  FirebaseUser loginuser;
  @override
  void initState() {
    getcurrentuser();
    super.initState();
  }
  void getcurrentuser ()async
  {

    try{
      final user=await _auth.currentUser();
      if(user!=null)
      {
        loginuser=user;
        print(loginuser.email);
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  /*
  void getmessage()async{
    final message=await _firestore.collection('message').getDocuments();
    for(var message in message.documents)
      {
        print(message.data);
      }
  }*/
  void messagestream()async{
    await for(var snapshort in _firestore.collection('message').snapshots()){
      for(var message in snapshort.documents){
        print(message.data);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
               // _auth.signOut();
               // Navigator.pop(context);
                messagestream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('message').snapshots(),
              builder: (context,snapsort){
                if(!snapsort.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent ,
                      ),

                    );
                  }
                    final messages=snapsort.data.documents;
                    List<Text>messageWidgets=[];
                    for(var message in messages)
                      {
                        final messagetext=message.data['text'];
                        final messagesender=message.data['sender'];
                        final messageWidget=Text('$messagetext from $messagesender',
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        );
                        messageWidgets.add(messageWidget);
                      }
                    return Expanded(
                      child: ListView(
                      children: messageWidgets,
                      ),
                    );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection('message').add({
                        'text':messageText,
                        'sender':loginuser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
