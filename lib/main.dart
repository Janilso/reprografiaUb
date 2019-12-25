import 'package:flutter/material.dart';
import 'package:reprografiaub/screen/token/tokenScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeScreen(title: 'Flutter Demo Home Page'),
      home: TokenScreen(),
    );
  }
}
