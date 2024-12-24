import 'package:flashcards/router/router.dart';
import 'package:flutter/material.dart';


import '../widget/button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  void login(){
    Navigator.pushNamed(context,Routes.logIn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Padding(
          padding:const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Form(
            key: _formKey,
            child:  Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  "Welcome back to the flashcards app",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: 10,),
                const TextFields(labels: "First Name", isPassword: false),
                const SizedBox(height: 10,),
                const TextFields(labels: "Last Name", isPassword: false),
                const SizedBox(height: 10,),
                const TextFields(labels: "Email", isPassword: false),
                const SizedBox(height: 10,),
                const TextFields(labels: "Password",isPassword: true,),
                const SizedBox(height: 10,),
                const TextFields(labels: "Confirm Password",isPassword: true,),
                const SizedBox(height: 30,),
                Button(nameButton: "Sign Up",onTap: login),
                const SizedBox(height: 20,),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: login,
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
        
            ),
          ),
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    super.key,
    required this.labels,
    required this.isPassword
  });

  final String labels;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration:  InputDecoration(
        label:  Text(labels),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700,width: 1),
          borderRadius:BorderRadius.circular(10),
    
        )
      ),
    );
  }
}

