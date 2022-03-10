import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/screens/update_database.dart';
import 'package:quiz_app/screens/verify.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String genderhere = 'Male';
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _miscontroller = TextEditingController();
  // List of items in the dropdown menu
  var items = [
    'Male',
    'Female',
    'Other',
  ];

  final _auth = FirebaseAuth.instance;
  User? user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/img/bg_img.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.darken),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 30),
                  child: Text(
                    'Your details here',
                    style: TextStyle(
                        fontSize: 45,
                       fontFamily: 'BreeSerif',
                       //fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
             
                Namefield(size: size, labelhere: 'Name', hinthere: 'Your Name', namecontroller: _namecontroller),
                SizedBox(height: size.height * 0.05),
                Namefield(size: size,labelhere: 'E-mail', hinthere: 'abc@email.com',  namecontroller: _emailcontroller),
                SizedBox(height: size.height * 0.05),
                Namefield(size: size, labelhere: 'MIS', hinthere: 'MIS/PRN', namecontroller: _miscontroller),
                SizedBox(height: size.height * 0.05),
                Namefield(size: size, labelhere: 'Create a Password', hinthere: 'Password', namecontroller: _passcontroller),
                SizedBox(height: size.height * 0.05),

                Container(
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: .5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 104, 177, 219),
            
          ),
                    child: DropdownButton(
                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600 )),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          genderhere = newValue!;
                        });
                      },
                      value: genderhere,
                    ),
                  ),
                ),
                
                SizedBox(height: size.height * 0.1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // ignore: sized_box_for_whitespace
                    Container(
                      height: size.height*0.055,
                      child: ElevatedButton(
                        
                        onPressed: () => signUp(_emailcontroller.text.trim(), _passcontroller.text.trim()),
                        
                        child: const Text(
                          'Sign Up and Attempt',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                        
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),      
                      ),
                    ),
                    
                  ],
                ),
             
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp(String _email, String _password) async{
    try{
    await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
    user = _auth.currentUser;
    user!.updateDisplayName(_namecontroller.text.trim());
    Databaseupdate(_auth.currentUser!.uid).updateuserdata(_namecontroller.text.trim(), _miscontroller.text.trim(), genderhere);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Verify()));
    } on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    }
    catch(e){
      Fluttertoast.showToast(msg: "Error signing up $e");
    }
  }
  


}


class Namefield extends StatelessWidget {
  const Namefield({
    Key? key,
    required this.size,
    required this.labelhere,
    required this.hinthere,
    required TextEditingController namecontroller,
  }) : _namecontroller = namecontroller, super(key: key);

  final Size size;
  final TextEditingController _namecontroller;
  final String labelhere;
  final String hinthere;
  
  
  @override
  Widget build(BuildContext context) {
   
    return Container(
    margin: const EdgeInsets.only(left: 40, right: 40),
   // width: size.width * 0.8,
    height: size.height*0.065,
    child: TextField(
      controller: _namecontroller,
      obscureText: hinthere == 'Password' ? true : false,
      keyboardType: hinthere == 'MIS/PRN' ? TextInputType.number : TextInputType.text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          label: Text(labelhere),
          hintText: hinthere),
    ),
    );
  }

  
}
