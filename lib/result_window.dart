import 'package:flutter/material.dart';


class Result extends StatelessWidget {
  final int unique ;
  final int total ;
  final int correct ;
  const Result({ Key? key, required this.total, required this.correct,required this.unique }) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result', style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 30,
        ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFe6d777),
      ),
      body: Column(children: <Widget>[
        
        Container(
          margin: EdgeInsets.only(top: 70,),
          child: Card(
            
            child: Container(
              decoration: const BoxDecoration(
                gradient:  LinearGradient(
                  colors: [
                    Color(0xFF81a1d3), Color(0xFF00bdef), Color(0xFF00d7d9), Color(0xFF575a50)                    
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Report(answerType: 'Total answers', num: total),
                    const SizedBox(height: 20,),
                    Report(answerType: 'Correct answers', num: correct),
                    const SizedBox(height: 20,),
                    Report(answerType: 'Unique answers', num: unique),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        )
      ]) 
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
      Text('$answerType: ', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
      Text('$num', style:  TextStyle(fontSize: 35, color: Colors.lightGreenAccent[400], fontWeight: FontWeight.bold),),
    ],);
  }
}