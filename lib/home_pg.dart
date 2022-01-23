import 'package:flutter/material.dart';
import 'package:quiz_app/result_window.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String answer = "some";
  List<String> validAnswers = ['circle', 'earth', 'ball', 'tyre'];
  List<String> userInput = ["nothing"];
  @override
  Widget build(BuildContext context) {
    int unique = 0, total = 0, correct = 0;
    Map<String, int> storeResult = { 'circle': 0, 'earth': 0, 'ball': 0, 'tyre': 0, 'wheel': 0, 'ring': 0};
    var size = MediaQuery.of(context).size;
    
    String _answer2 = "emp";
    return DefaultTabController(
      length: 4,
      child: Scaffold(
       // backgroundColor: Colors.blue[300],
      // backgroundColor: const Color(0xFFd99f52),
      appBar: AppBar(
        title: const Text('Title here'),
        bottom: const TabBar(
          isScrollable: true,
          tabs: [
            Text('Question 1', style: (TextStyle(fontSize: 20)),),
            Text('Question 2', style: (TextStyle(fontSize: 20)),),
            Text('Question 3', style: (TextStyle(fontSize: 20)),),
            Text('Question 4', style: (TextStyle(fontSize: 20)),),
            ],
        ),
        flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: <Color>[Colors.black45, Colors.black]),
        ),
      ),
      ),
      body:SingleChildScrollView(
        reverse: true,
        child: Column(  // change Column to Stack
          children: <Widget>[
              header(size),
              const SizedBox(height: 10),
              Column(
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
                  SizedBox(height: size.height*0.05,)
                ] ,
              )
          ],
            ),
      )
        
      ),
    );


  }

  Stack header(Size size) {
    return Stack
          (
            children: <Widget>[ 
              Container(
              height: size.height*0.32,
              decoration:const  BoxDecoration(
                color:  Color(0xff123456), //0xFFF5CEB8
                borderRadius:  BorderRadius.only(
                  bottomRight: Radius.circular(45.0),
                  bottomLeft: Radius.circular(45.0),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  height: size.height*.2,
                  width: size.width*.4,
                  
                  decoration:const BoxDecoration(                        
                    image: DecorationImage(
                      image: AssetImage('assets/img/quiz_logo.png'),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                const Text('Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'BilboSwashCaps',
                  fontSize: 60,
                  letterSpacing: 8,
                  fontWeight: FontWeight.bold,
                ),
                )
              ]
          ),
            ],
          );
  }
}