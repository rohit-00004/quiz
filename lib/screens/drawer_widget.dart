import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/screens/home_pg.dart';
import 'package:quiz_app/screens/landing.dart';
import 'package:quiz_app/screens/user_info.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({ Key? key }) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 65, 48, 141),
        child: ListView(
          children: [
            navbarItem(icon: Icons.person, titlehere: 'User Profile', onClick: () => selectedpage(context, 0)),
            const Divider(color: Colors.white,),
            navbarItem(icon: Icons.question_answer, titlehere: 'Question 1', onClick: () => selectedpage(context, 1)),
            navbarItem(icon: Icons.question_answer, titlehere: 'Question 2', onClick: () => selectedpage(context, 2)),
            navbarItem(icon: Icons.send, titlehere: 'Question 3-10', onClick: () => selectedpage(context, 3)),
            const Divider(color: Colors.white,),
            navbarItem(icon: Icons.logout, titlehere: 'Log Out', onClick: () => selectedpage(context, 4)),

          ],
        ),
      ),
    );
  }

  void selectedpage(BuildContext context, int idx){
    Navigator.of(context).pop();
    switch (idx) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserInformation()));        
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));        
        break;
      case 4:
        signOut(context);       
        break;


      default:
    }
  }
  signOut(BuildContext context) async{
    try{
    await _auth.signOut();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Enter())); 
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

  Widget navbarItem({required String titlehere, required IconData icon, required VoidCallback onClick}) {
    const color = Colors.white;

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: ListTile(
        leading: Icon(icon, size: titlehere == 'User Profile' ? 30 : 25, color: color,),
        title:  Text(titlehere, style: TextStyle(color: color, fontSize: titlehere == 'User Profile' ? 20: 18),),
        onTap: onClick,
      ),
    );
  }


