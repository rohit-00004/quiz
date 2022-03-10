import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/screens/home_pg.dart';
import 'package:quiz_app/screens/reset.dart';
import 'package:quiz_app/screens/sign_up.dart';

class Enter extends StatefulWidget {
  const Enter({Key? key}) : super(key: key);

  @override
  State<Enter> createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  late String _email, _password;
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
              'Welcome to Quiz',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                wordSpacing: 3,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
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
                    hintText: 'Email'
                    ),
              ),
            ),
          
            SizedBox(
              height: size.height * 0.05,
            ),
          
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              width: size.width * 0.8,
              height: size.height*0.065,
              child: TextField(
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    _password = val;
                  });
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    label: const Text('Password'),
                    hintText: 'Password'),
              ),
            ),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reset()));
            }, child: const Text('Forgot Password?')
            ),
          
            // ignore: sized_box_for_whitespace
            Container(
              width: size.width * 0.5,
              height: size.height * 0.05,
              child: ElevatedButton(
                  child: const Text('Sign In', style: TextStyle(fontSize: 16),),
                  onPressed: () => signIn(_email, _password),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  ),
            ),
            
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text(
                'OR',
                style: TextStyle(
                    color: Colors.blue, fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    ),
              ),
            ),

            // ignore: sized_box_for_whitespace
            Container(
              width: size.width * 0.5,
              height: size.height * 0.05,
              child: ElevatedButton(
                child: const Text('Sign Up', style: TextStyle(fontSize: 16),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Page1(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
                ]
                ),
            
          //   ],
          // ),
          ),
      ));
  }

  signIn(String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error signing in $e");
    }
  }
}




/*  IMAGE
 decoration: BoxDecoration(
          image: DecorationImage(
             image: const AssetImage("assets/img/bg_signin.jpg"),
             fit: BoxFit.cover,
             colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken)
          )
        ),


*/