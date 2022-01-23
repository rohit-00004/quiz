import 'package:flutter/material.dart';
import 'package:quiz_app/result_window.dart';


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
  int unique = 0, total = 0, correct = 0;
  Map<String, int> storeResult = { 'circle': 0, 'earth': 0, 'ball': 0, 'tyre': 0, 'wheel': 0, 'ring': 0};
  String answer = "some";
  List<String> validAnswers = ['circle', 'earth', 'ball', 'tyre'];
  List<String> userInput = ["nothing"];  
  @override
  Widget build(BuildContext context) {
    String _answer2 = "emp";
    return Column(
      children:<Widget>[
        Container(
          height: 60,
          padding: const EdgeInsets.only(left: 25, top: 5),
          width: double.infinity,
          child: const Text('Q1. Name 10 objects resembling\n \t\t\t\t\t\ta circle: ',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            fontSize: 22,
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
          // onPressed: (){},
          onPressed: (){
            setState(() {
              _answer2 = answer; 
            _answer2 = _answer2.replaceAll(' ', '');
            //print(_answer2);
            userInput = _answer2.split(',');
            //print(userInput);
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
            print(total);
            print(correct);
            print(unique);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(total: total, correct: correct, unique: unique)));
            });           
            
          }, 
    
          child: const Text('Submit', 
          style: TextStyle(fontSize: 17),),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          ),
          
        ),
        SizedBox(height: widget.size.height*0.05,)
      ] ,
    );
  }
}