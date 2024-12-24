import 'package:flashcards/router/router.dart';
import 'package:flashcards/widget/button.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  
  void toHomeScreen(){
   Navigator.pushNamed(context, Routes.home);
  }

  void signUp(){
    Navigator.pushNamed(context, Routes.signUp);
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
                  "Log In",
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
                const TextFields(labels: "Email", isPassword: false),
                const SizedBox(height: 10,),
                const TextFields(labels: "Password",isPassword: true,),
                const SizedBox(height: 30,),
                Button(nameButton: "Log In",onTap:toHomeScreen),
                const SizedBox(height: 20,),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: signUp,
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 20,)
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