import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forget-pwd.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // text controllers

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool loading = false;
  String errorMessage = '';



  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passwordcontroller.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      errorMessage= error.message!;

    }catch(e,s){
      print(e);
      print(s);
    }

  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(

        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(
                  Icons.task,
                size: 75),

                 SizedBox(height: 75),

                // greetings

               Text('Hello Again!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),

              SizedBox(height: 10),
              
              const Text("Welcome back, you \'ve been missed!",
              style: TextStyle(
                fontSize: 20,
              ),
              ),

              SizedBox(height: 50),

              //email textfield

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
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)
                          { return ForgetPasswordPage();},),);
                        },
                        child: Text('forget password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ],
                ),
              ),
                SizedBox(height: 10),

                Center(child: Text(errorMessage,style: TextStyle(color: Colors.red),)),

              SizedBox(height: 25),

              //sign in button

                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),

                child: GestureDetector(
                  onTap: signIn,
                  child: Container(

                    padding: EdgeInsets.all(25),
                    decoration:  BoxDecoration(
                        color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                    ),
                    child:  Center(child: Text('Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              
              //not a member
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children : [

                Text('New users?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                ),


                  GestureDetector(
                   onTap: widget.showRegisterPage,
                  child: Text(' Register now',
                style: TextStyle(
                   color: Colors.blue,
                   fontWeight: FontWeight.bold,
                 ),
                 ),
               ),
            ],

        ),

              ],

            ),
          ),
        ),
      ),

    );
  }
}
