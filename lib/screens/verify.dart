import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/screens/home_pg.dart';



class Verify extends StatefulWidget {
  const Verify({ Key? key }) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  
  final _auth = FirebaseAuth.instance;
  User? user ;
  Timer? timer;
  AlertDialog? alert;
  @override
  void initState() {
    user = _auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
     });
    alert =  AlertDialog(
    title: const Text("Confirm Email"),
    content: Text("An email has been sent to ${user!.email}, please verify"),
    
  );
    super.initState();
  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: alert,
    );
  }

  Future<void> checkEmailVerified() async{
    user = _auth.currentUser;
    await user!.reload();
    if(user!.emailVerified){
      timer!.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const Home())));
    }
  }
}