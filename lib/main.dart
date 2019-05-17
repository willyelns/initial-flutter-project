import 'package:flutter/material.dart';
import 'package:login_fb/pages/login_signup_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context)  {
    _changeStatusBar();
    return new MaterialApp(
      title: 'Mana Initial Prototype',
      theme: new ThemeData(
        primarySwatch: Colors.pink
      ),
      home: new LoginSignUpPage()
    );
  }

  void _changeStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.pink,
      statusBarColor: Colors.pink,
    ));
  }
}