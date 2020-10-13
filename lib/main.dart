import 'package:flutter/material.dart';
import 'package:wall_paper_app/views/home.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Home(),
    );
  }
}