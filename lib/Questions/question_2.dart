import 'package:flutter/material.dart';
import 'package:quiz_app/Questions/question_3_10.dart';

class Question2 extends StatefulWidget {
  final List<int> previousData;
  const Question2({Key? key, required this.previousData}) : super(key: key);

  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  String answer = "some";
  String answer2 = "nothing";
  List<String> userinput = ["to_be_taken"];
  String backkup = "-1";
  late List<int> prevData;
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    prevData = widget.previousData;
    List<String> unique = ["not_yet"];
    Map<String, int> automobiles = {
      'Tata': 0,
      'Ford': 0,
      'Suzuki': 0,
      'Mercedes': 0,
      'BMW': 0,
      'Audi': 0
    };
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
            children: <Widget>[
              header(size),
              const SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding: const EdgeInsets.only(left: 25, top: 5),
                    width: double.infinity,
                    child: const Text(
                      'Q2. Name automobile companies',
                      style: TextStyle(
                        fontFamily: 'AkayaTelivigala',
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 25,
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: TextField(
                      maxLines: 10,
                      onChanged: (val) {
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
                        hintText:
                            'Your answer(first letter uppercase for each), separated by commas',
                        //labelText: 'Answer',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          answer2 = answer;
                          setState(() {
                            answer2 = answer2.replaceAll(' ', '');
                            userinput = answer2.split(',');

                            for (var v in userinput) {
                              if (automobiles.containsKey(v)) {
                                automobiles.update(v, (value) => value + 1);
                              }
                            }

                            automobiles.forEach((key, value) {
                              if (value == 1) {
                                unique.add(key);
                              }
                            });

                            if (unique.length == 2) {
                              // prevData.add(unique[1]);
                              backkup = unique[1];
                              // debugPrint(backkup);
                              // debugPrint('$prevData');
                              //prevData[3] = unique[1];
                              //  debugPrint(unique[1]);
                            } else {
                              backkup = "No unique ";
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Getjson(
                                    answerToFirst: prevData,
                                    answerTosecond: backkup,
                                  )));
                          });
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  )
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
