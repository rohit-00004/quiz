import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _EnterState();
}

class _EnterState extends State<Reset> {
  late String _email;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            const Image(image: AssetImage('assets/img/landing2.png')),
           
            const Text(
              'Don\'t worry, we got you!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              width: size.width * 0.8,
              height: size.height*0.065,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    label: const Text('Email'),
                    hintText: 'registered e-mail address'),
              ),
            ),
          
            SizedBox(
              height: size.height * 0.05,
            ),
            
            // ignore: sized_box_for_whitespace
            Container(
              width: size.width * 0.5,
              height: size.height * 0.05,
              child: ElevatedButton(
                  child: const Text('Get reset link', style: TextStyle(fontSize: 16),),
                  onPressed: () => resetlink(_email),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  ),
            ),
            
                ]
                ),
          ),
      ));
  }
  void showsnackBar(BuildContext context){
  var snackBar = SnackBar(
  content: Text('A reset link was sent to $_email'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  resetlink(String _email) async {
    try {
      await _auth.sendPasswordResetEmail(email: _email);

      Navigator.of(context).pop();
      showsnackBar(context);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error sending link $e");
    }
  }
}



