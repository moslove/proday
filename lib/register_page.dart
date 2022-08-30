import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {

  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // text controllers

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();



  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    _ageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }


  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text,
      );

      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailcontroller.text.trim(),
        int.parse(_ageController.text.trim()),

      );
    }
  }



  Future addUserDetails(String firstName, String lastName, String email,
      int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name ':firstName,
      'last name ': lastName,
      'age ' : email,
      'email ' : age,

    });
  }



  bool passwordConfirmed() {
    if (_passwordcontroller.text ==
        _confirmpasswordcontroller.text) {
      return true;
    }
    else {
      return false;
    }
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

                Text('Hello There!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),

                SizedBox(height: 10),

                const Text("Register below with your details",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 50),

                //first name

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
                        controller: _firstNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'first name',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),


                //last name

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
                        controller: _lastNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'last name',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // age

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
                        controller: _ageController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'age',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),






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
                        controller: _confirmpasswordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'confirm Password',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                //sign in button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),

                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(25),
                      decoration:  BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Center(child: Text('Sign Up',
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

                    Text('Already have an Account?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(' Login now',
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



