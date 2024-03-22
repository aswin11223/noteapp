import 'package:flutter/material.dart';
import './HomeScreen.dart';

class  MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Example',
      home: HomeScreen(),
      
      
    );
  }
}