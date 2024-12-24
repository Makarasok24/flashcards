import 'package:flashcards/router/router.dart';
import 'package:flashcards/widget/button.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/welcomeCard.png",
                width: 400,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome to the Flashcards app",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  "We're excited to help you book and manage your service appointment with ease.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Button(
                nameButton: "Get Start",
                onTap: () {
                  Navigator.pushNamed(context, Routes.navigationMenu);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
