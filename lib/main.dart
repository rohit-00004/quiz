import 'package:flutter/material.dart';
import 'package:quiz_app/home_pg.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.brown,
      // ),
     
      title: 'Quiz app',
      home: Home(),

    );
  }
}