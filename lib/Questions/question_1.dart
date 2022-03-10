import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Questions/question_2.dart';
//import 'package:quiz_app/result_window.dart';


class Question1 extends StatefulWidget {
  const Question1({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  final auth = FirebaseAuth.instance;
  
  int unique = 0, total = 0, correct = 0;
  Map<String, int> storeResult = { 'circle': 0, 'earth': 0, 'ball': 0, 'tyre': 0, 'wheel': 0, 'ring': 0};
  String answer = "some";
  List<String> userInput = ["nothing"];  
  List<int> previousData = [];

  @override
  Widget build(BuildContext context) {
    
    String _answer2 = "emp";
    return  Column(
        children:<Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            padding: const EdgeInsets.only(left: 25, top: 5),
            width: double.infinity,
            child: const Text('Q1. Name objects resembling a\n circle: ',
            style: TextStyle(
              fontFamily: 'AkayaTelivigala',
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              fontSize: 25,
            ),),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              )
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              maxLines: 10,
              onChanged: (val){
                setState(() {
                  answer = val;
                });
              },
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
                hintText: 'Your answer, separated by commas',
                //labelText: 'Answer',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              setState(() {
                _answer2 = answer; 
              _answer2 = _answer2.replaceAll(' ', '');
              userInput = _answer2.split(',');
              for(int i=0; i<userInput.length; i++){
                for(var v in storeResult.entries){
                  if(v.key == userInput[i]){
                    storeResult.update(
                      userInput[i],
                      (value) => ++value,
                      ifAbsent: () => 0,
                    );
                  }
                }
              }
              total = userInput.length;
              for(var v in storeResult.values){
                if(v >= 1) unique++;
              }
              int tmp = 0;
              for(var v in userInput){
                if(!(storeResult.containsKey(v))){
                  tmp++;
                }
              }
              correct = total - tmp;
              
              if(userInput.length == 1 && userInput[0] == 'some') total = 0;
              // debugPrint(total.toString());
              // debugPrint(correct.toString());
              // debugPrint(unique.toString());
             previousData.add(total);
             previousData.add(unique);
             previousData.add(correct);
             debugPrint('$previousData');
             debugPrint('${auth.currentUser!.displayName}');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Question2(previousData: previousData)));
               });           
            }, 
      
            child: const Text('Next', 
            style: TextStyle(fontSize: 17),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            
          ),
          SizedBox(height: widget.size.height*0.05,)
        ] ,
      );
  
  }
}