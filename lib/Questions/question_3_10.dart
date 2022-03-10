import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:quiz_app/Questions/question_2.dart' as helper;
import 'package:quiz_app/screens/result_window.dart';
import 'package:quiz_app/screens/update_database.dart';


class Getjson extends StatelessWidget {
  final List<int> answerToFirst;
  final String answerTosecond;
  const Getjson({Key? key, required this.answerToFirst, required this.answerTosecond}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
        builder: (context, snapshot) {
          var data = json.decode(snapshot.data.toString());
          if(data == null){
            return const Scaffold(
              body: Center(child: Text('Loading'),),
            );
          }
          else{
          return Question3To10(data: data, answerToFirst: answerToFirst, answerTosecond: answerTosecond,);
          }
        });
  }
}

class Question3To10 extends StatefulWidget {
  final List data;
  final List<int> answerToFirst;
  final String answerTosecond;
  const Question3To10({Key? key, required this.data,required this.answerToFirst, required this.answerTosecond}) : super(key: key);

  @override
  State<Question3To10> createState() => _Question3To10State();
}

class _Question3To10State extends State<Question3To10> {
  Color displaycolor = Colors.indigoAccent;
  Color correct = Colors.green;
  Color wrong = Colors.red;
  final _auth = FirebaseAuth.instance;
  int marks = 0;
  int i = 3;
  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  dynamic data;
  dynamic answerToFirst;
  dynamic answerTosecond;
  @override
  void initState() {
    
    data = widget.data;
   answerToFirst = widget.answerToFirst;
    answerTosecond = widget.answerTosecond;
    super.initState();
  }
 
  
  @override
  Widget build(BuildContext context) {
  // var data = widget.data;              initstate() used for this initialization
  // List<int> answerToFirst = widget.answerToFirst;
  // String answerTosecond = widget.answerTosecond;
  void nextquestion(String k) {
    
    setState(() {
     
      if (i < 10) {
        if(i == 3){
          debugPrint('$answerToFirst');
        }
        i++;
      } 
      else {
          Databaseupdate(_auth.currentUser!.uid).updateuserscore(marks, answerToFirst[1], answerTosecond);
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Result(answerToFirst:answerToFirst, answerTosecond: answerTosecond, mcqTotal: marks,)));
      }
      
   
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
  
    });
   
  }

  void verifyanswer(String k) async{
    if(data[2][i.toString()] == data[1][i.toString()][k]){
       marks += 5;
       displaycolor = correct;
    }
    else{
       displaycolor = wrong;
    }

    setState(() {
      btncolor[k] = displaycolor;
    });
    
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500), (){});
    nextquestion(k);
  

  }
  Widget choicebutton(String opt) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          verifyanswer(opt);
        },
        child:  Text(
          data[1][i.toString()][opt],
          style:const TextStyle(
            color: Colors.white,
            // fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[opt],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
  
    var size = MediaQuery.of(context).size;
    return Scaffold(

        appBar: AppBar(
          title: const Text('Quiz'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.black45, Colors.black]),
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            // change Column to Stack
            children: <Widget>[
              header(size),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child:  Text(
                  'Q.$i ${data[0][i.toString()]}',
                  style: const TextStyle(
                    fontFamily: 'AkayaTelivigala',
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    fontSize: 25,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choicebutton("a"),
                  choicebutton("b"),
                  choicebutton("c"),
                  choicebutton("d"),
                ],
              )
            ],
          ),
        ));
  }

  Stack header(Size size) {
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.32,
          decoration: const BoxDecoration(
            color: Color(0xff123456), //0xFFF5CEB8
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(45.0),
              bottomLeft: Radius.circular(45.0),
            ),
          ),
        ),
        Row(children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            height: size.height * .2,
            width: size.width * .4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/quiz_logo.png'),
              ),
              shape: BoxShape.rectangle,
            ),
          ),
          const Text(
            'Quiz',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'BilboSwashCaps',
              fontSize: 60,
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ],
    );
  }
}
