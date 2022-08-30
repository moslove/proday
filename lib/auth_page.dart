import 'package:flutter/material.dart';
import 'package:proday/login_page.dart';
import 'package:proday/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  //initially showing login page

  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });

  }
  @override
  Widget build(BuildContext context) {

    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    }

    else {return RegisterPage(showLoginPage: toggleScreens );}
  }
}
