import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget{
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async{
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();    //notification settings can also be added here!

    fcm.subscribeToTopic('chat');     // Backend on node, not done 

    final token = await fcm.getToken();
    print(token);   //you could send this token via HTTP or firestore SDK instead of copy pasting it.
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Chats'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
            )
        ],
      ),
      body: Column(children: [
        Expanded(child: ChatMessages()),
        NewMessage(),
      ],),
    );
  }
}