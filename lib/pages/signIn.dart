// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/auth/google_service.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/pages/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthClass _authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fresh Vegetable',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 34,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 4,
                        offset: Offset(3, 2),
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    width: 300,
                    child: Image.asset('assets/home_bg.png')
                    // Image.network(
                    //   'https://firebasestorage.googleapis.com/v0/b/fresh-vegetable-1918b.appspot.com/o/home_bg.png?alt=media&token=51f9e97d-eff2-4c7f-9c16-9800cc0c37f9',
                    // ),
                    ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () async {
                      await _authClass.handleSignIn(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: SizedBox(
                      height: 62,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.lightGreen),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/google.png'),
                            Text(
                              'Continue with google',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
