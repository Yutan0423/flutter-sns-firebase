import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_firebase/utils/authentication.dart';
import 'package:flutter_sns_firebase/utils/firestore/users.dart';
import 'package:flutter_sns_firebase/view/screen.dart';
import 'package:flutter_sns_firebase/view/start_up/create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text('Flutterラボ SNS', style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'メールアドレス'
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: 'パスワード'
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(text: 'アカウントを作成してない方は'),
                    TextSpan(
                      text: 'こちら',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const createAccountPage()));
                      }
                    )
                  ]
                ),
              ),
              const SizedBox(height: 70,),
              ElevatedButton(
                onPressed: () async {
                  var result = await Authentication.signIn(email: emailController.text, pass: passController.text);
                  if(result is UserCredential) {
                    var _result = await UserFirestore.getUser(result.user!.uid);
                    if(_result == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Screen())
                      );
                    }
                  }
                },
                child: const Text('ログイン'))
            ],
          ),
        ),
      ),
    );
  }
}