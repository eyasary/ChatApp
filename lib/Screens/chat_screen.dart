import 'package:chatapp/Screens/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';


final _firestore = FirebaseFirestore.instance;
late User userSig;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
 
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageContoller=TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? message;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        userSig = user;
        print(userSig.email);
      }
    } catch (e) {
      print(e);
    }
  }

  /* void getMessages()async{
    final messges=await _firestore.collection('messages').get();
    for(var msg in messges.docs){
       print(msg.data());
    }
   }*/
  /*void msgStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var msg in snapshot.docs) {
        print(msg.data());
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(
            Icons.menu,
            color: primaryColor,
          ),
          title: Text(
            'Chatter',
            style: TextStyle(color: primaryColor),
          ),
          actions: [
            IconButton(
                onPressed: () {
                   _auth.signOut();
                  Navigator.pop(context);
                  //msgStream();
                },
                icon: Icon(
                  Icons.close,
                  color: primaryColor,
                ))
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MessageStramBuilder(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 248, 237, 237),
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ]),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageContoller,
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Tap your message here ..',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {
                            messageContoller.clear();
                            _firestore.collection('messages').add({
                              'sender': userSig.email,
                              'text': message,
                              'time':FieldValue.serverTimestamp()
                            });
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class MessageStramBuilder extends StatelessWidget {
  const MessageStramBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<Message> messageWidgets = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser=userSig.email;
          if(currentUser==messageSender)
          {
              
          }
          final messageWidget =
              Message(sender: messageSender, text: messageText, isMe: currentUser==messageSender,);
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          
          child: ListView(
            reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets),
        );
      },
    );
  }
}

class Message extends StatelessWidget {
  const Message({super.key, required this.sender, required this.text, required this.isMe});
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe?BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
            ):BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
            ),
            color: isMe?Colors.blue:Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 15, color: isMe?Colors.white:Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
