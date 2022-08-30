import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
     super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email:_emailcontroller.text.trim());
      showDialog(context: context,
        builder: (content) {
          return AlertDialog(
              content: Text('Password reset link sent! Check your mail'),
          );
        },
      );
    }
    on FirebaseAuthException catch (e) {
      print(e);
    showDialog(context: context,
        builder: (content){
      return AlertDialog(
        content: Text(e.message.toString()),
      );
      },
    );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor : Colors.deepPurple[200],
      elevation: 0,),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text('Enter your Email and we will send you a password reset link',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,),),
        ),

          SizedBox(height: 10),

          Padding(
          padding: const EdgeInsets.symmetric( horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),
        
        MaterialButton(
            onPressed: passwordReset,
          child: Text('Reset Password'),
            color: Colors.deepPurple[200],
        ),
  ],
      ),

    );
  }
}

