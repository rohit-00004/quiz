import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({ Key? key }) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInformation> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Your profile'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.black45, Colors.black]),
            ),
          ),
        ),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Name', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              Text('${_auth.currentUser!.displayName}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              
            ],
          ),
        ]),
    );
  }
}