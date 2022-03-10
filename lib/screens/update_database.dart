import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Databaseupdate{
  String userid;
  Databaseupdate(this.userid);

  Future updateuserdata(String name, String mis, String gender) async{
    try{
    await FirebaseFirestore.instance.collection('User Profile').doc(userid).set(
      { 
        'Name': name, 
        'MIS' : mis,
        'Gender' : gender 
      }
    );
    }catch(e){
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  Future updateuserscore(int mcqtotal, int uniquetofirst, String answertosecond) async{
    try{
    await FirebaseFirestore.instance.collection('User Profile').doc(userid).collection('Result').add(
      {
        'MCQ score' : mcqtotal,
        'Unique answers to first' : uniquetofirst,
        'Answer to second' : answertosecond
      }
    );
    }catch(e){
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

}