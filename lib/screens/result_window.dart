import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/landing.dart';


class Result extends StatelessWidget {
  final List<int> answerToFirst;
  final String answerTosecond;
  final int mcqTotal;
  Result({ Key? key, required this.answerToFirst, required this.answerTosecond,required this.mcqTotal}) : super(key: key);
  
  final _auth = FirebaseAuth.instance; 
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
          leading: GestureDetector(
                  child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.home, size: 30,),
                ),
                onTap:() {
                _auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Enter()));
                },
              ),

          title: const Text('Result', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.black45, Colors.black]),
            ),
          ),
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:const EdgeInsets.only(top: 50,),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                        colors:  [
                          Color(0xFF81a1d3), Color(0xFF00bdef), Color(0xFF00d7d9),                    
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Q1', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, )),
                          const SizedBox(height: 10,),
                          Report(answerType: 'Total answers', num: answerToFirst[0]),
                          const SizedBox(height: 20,),
                          Report(answerType: 'Correct answers', num: answerToFirst[2]),
                          const SizedBox(height: 20,),
                          Report(answerType: 'Unique answers', num: answerToFirst[1]),
                          // ElevatedButton(onPressed: ()=>tp(), child: const Text('hit me'))
                        ],
                      ),
                    ),
                  ),
                
              ),
      
            ],),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:const EdgeInsets.only(top: 50,),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                        colors:  [
                          Color(0xFF81a1d3), Color(0xFF00bdef), Color(0xFF00d7d9),                    
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        const Text('Q2', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, )),
                        const SizedBox(height: 10,),
                          Row(children: <Widget>[
                            const Text('Unique answer: ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 151, 70, 3)),),
                            Text(answerTosecond, style: const TextStyle(fontSize: 26, color: Color.fromARGB(255, 10, 92, 21), fontWeight: FontWeight.bold),),
                          ],)
                        ],
                      ),
                    ),
                  ),
                
              ),
      
            ],),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:const EdgeInsets.only(top: 50,),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                        colors:  [
                          Color(0xFF81a1d3), Color(0xFF00bdef), Color(0xFF00d7d9),                    
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        const Text('Q3', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, )),
                        const SizedBox(height: 10,),
                        const Report(answerType: 'Total MCQs: ', num: 8),
                        Report(answerType: 'Correct MCQs: ', num: (mcqTotal/5).round()),
                        Report(answerType: 'Total marks: ', num: mcqTotal),
                        
                        ],
                      ),
                    ),
                  ),
                
              ),
      
            ],),
            
            const SizedBox(height: 50,),
      
        ]),
      ) 
      );
  }
  
}

class Report extends StatelessWidget {
  final String answerType;
  final int num;
  const Report({
    Key? key,
    required this.answerType, required this.num,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text('$answerType: ', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 151, 70, 3)),),
      Text('$num', style:  const TextStyle(fontSize: 27, color: Color.fromARGB(255, 10, 92, 21), fontWeight: FontWeight.bold),),
    ],);
  }
}
