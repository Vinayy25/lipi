import 'package:flutter/material.dart';
import 'package:lipi/utils.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(7, 15, 43, 1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/hi_bot.png',
                height: 300,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: AppLargeText(
                  text:
                      "Unlock the Power of\nLipi \nTransform Your Kannada Speech into Text, Instantly!",
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  fontsize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                onPressed: () {},
                text: 'Get Started',
                fontWeight: FontWeight.bold,
                myTextColor: Colors.black,
                buttonColor: const Color.fromRGBO(146, 144, 195, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
