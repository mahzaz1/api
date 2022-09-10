import 'package:api/Example4.dart';
import 'package:api/Example5.dart';
import 'package:api/imageUpload.dart';
import 'package:api/login.dart';
import 'package:flutter/material.dart';
import 'example1.dart';
import 'example2.dart';
import 'Example3.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageUpload()
    );
  }
}



